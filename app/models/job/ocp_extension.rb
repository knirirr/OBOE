class Job
  module OcpExtension
    def process_new_ocp
      # before processing, we must check to see that the requirements are met
      # these are:
      # Maximum number of sequences is 200 for proteins and 200 for nucleic acids.
      # Maximum length of sequences is 2000 for proteins and 6000 for nucleic acids.
      toolong = 0
      data = Bio::FlatFile.auto(StringIO.new(self.infile.read.force_encoding('UTF-8')))
      if data.to_a.length > 200
        jobfail("Too many sequences for #{self.id}: ","too many sequences (>200)")
        return
      end
      # this stuff below (all the string conversions &c.) is shocking. If you have any
      # better way of finding out whether a string is an aa or na seq then please feel
      # free to update this, as that's all it's supposed to do
      data.each_entry do |e|
        length = e.seq.length
        if Bio::Sequence.auto(e.seq.to_s).guess.to_s == "Bio::Sequence::NA"
          if length > 6000
            toolong += 1
          end
        else
          if length > 2000
            toolong += 1
          end
        end
      end
      if toolong > 0
        jobfail("Excessive (#{toolong}) sequences for #{self.id}: ","#{toolong} sequences too long")
        return
      end
        
      # this section processes the job
      tries = 0
      url = "http://www.phylogeny.fr/version2_cgi/simple_phylogeny.cgi"
      agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      # setup connection
      begin
        page = agent.get(url)
        form = page.form('oneclick_form')
        form.workflow_name = self.job_name
        form.task_data_input = self.infile.read.force_encoding('UTF-8')
        #form.email = 'noreply.left@oerc.ox.ac.uk'
        form.email = 'milo.thurston@oerc.ox.ac.uk'
      rescue
        tries += 1
        if tries <= 3
          Rails.logger.error("OCP1: retry #{tries}")
          sleep 5
          retry
        else
          jobfail("OCP get form fail: #{self.id}: ","could not open communications with OCP server")
          return
        end
      end
      # submit the form
      tries = 0
      begin
        page = agent.submit(form) # may fail here
      rescue
        tries += 1
        if tries <= 3
          Rails.logger.error("OCP2: retry #{tries}")
          sleep 5
          retry
        else
          jobfail("OCP submit fail: #{self.id}: ","data submission to remote server failed")
          return
        end
      end
      # find the URL to get the results
      tries = 0
      begin
        self.parameters['result_url'] = page.links_with(:text => /this link/)[0].href
      rescue
        tries += 1
        if tries <= 3
          Rails.logger.error("OCP3: retry #{tries}")
          sleep 5
          retry
        else
          jobfail("OCP get link fail: #{self.id}: ","could not get result url")
          return
        end
      end
      self.status = "in progress"
      self.save
    end

    def check_progress_ocp
     agent = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
      page = agent.get(self.parameters['result_url'])
      begin
        data =  page.links_with(:text => /Newick/)[0].click
        outfile = File.open("/tmp/#{self.id}.nwk","w")
        outfile.puts(data.body)
        self.outfile = File.open(outfile)
        outfile.close
        File.unlink(outfile)
        self.save
        self.update_attributes(:status => 'finished')
        user = User.find_by_email(self.email)
        UserMailer.job_ready(user,self).deliver 
      rescue
        if self.check_count > 20
          self.jobfail("OCP #{id} failed ","no response from analysis server")
        else
          Rails.logger.error("OCP #{self.id} not ready") # add a count here later
        end
      end
    end
  end
end
