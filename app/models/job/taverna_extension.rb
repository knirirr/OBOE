class Job
  module TavernaExtension
    def process_new_taverna
      # let the taverna server on karakal do the work
      server = "http://172.24.13.85:8080/taverna-server"
      baseurl = "rest/runs"
      unless Dir.exists?(workdir)
        FileUtils.mkdir_p(workdir) 
      end
      # this wrapping won't be needed for > 2.2a1
      # use application/vnd.taverna.t2flow+xml for > 2.2a1
      # DAMN: I forgot that one can't stream XML here because Rails doesn't like it!
      # This may have to be replaced by using the infile for the workflow and pasting in other files,
      # but that is less than ideal unless it's the Scratchpad which reads them and posts the data...
      # instead, we will now use a workflow stored on disk somewhere.
      if server =~ /2\.2a1$/
        workflow = '<workflow xmlns="http://ns.taverna.org.uk/2010/xml/server/">' + self.parameters['workflow'] + '</workflow>'
        content_type = 'application/xml'
      else
        workflow = self.parameters['workflow']
        content_type = 'application/vnd.taverna.t2flow+xml'
      end

      # send the workflow to the server
      begin
        resource = RestClient::Resource.new "#{server}/#{baseurl}"
        response = resource.post workflow, :content_type => content_type
        jobid = response.headers[:location].split(/\//)[-1]
      rescue
        jobfail("Failed to submit workflow to server ","could not submit workflow")
        return
      end

      if jobid.blank?
        # presumably the server responded but didn't create the job
        jobfail("Workflow not accepted by server ","workflow not accepted by server")
        return
      end

      # increase the job expiry time by 20 minutes
      # ...there might be problems if karakal's clock is wrong
      begin
        url = "#{server}/#{baseurl}/#{jobid}/expiry"
        resource = RestClient::Resource.new url
        time = Time.now + (2 * 60 * 60)
        response = resource.put time.iso8601.gsub(/\+00:00$/,".000+0000"), :content_type => 'text/plain'
      rescue
        Rails.logger.error("Attempt to update expiry time for job #{self.id} failed.")
        # not worried about a jobfail here; it may still run if we carry on...
      end

      # get the input into the job. This may be an input field, or it may be a file, or both
      # I think this might work. First, for any inputs, loop over eacy and set them as follows 
      self.parameters['input'].split("|").each do |input|      
        inport,inval = input.split(":")
        url = "#{server}/#{baseurl}/#{jobid}/input/input/#{inport}"
        doc = <<EOF
<t2sr:runInput xmlns:t2sr="http://ns.taverna.org.uk/2010/xml/server/rest/">
    <t2sr:value>#{inval}</t2sr:value>
</t2sr:runInput>
EOF
        begin 
          resource = RestClient::Resource.new url
          response = resource.put doc, :content_type => 'application/xml'
        rescue
          jobfail("Could not set input value for \"#{inport}\" ","#{inport} value could not be set")
          return
        end
      end

      # now upload a file if it exists, though I'm damned if I know how
      unless self.infile.blank?
        # DO THIS LATER
      end


      # assuming all the inputs are set up...
      url = "#{server}/#{baseurl}/#{jobid}/status"
      resource = RestClient::Resource.new url
      response = resource.put "Operating", :content_type => 'text/plain'
      if response.body == 'Operating'
        self.update_attributes(:status =>'in progress')
      else
        jobfail("Could not start workflow running","remote workflow activation failed")
      end
    end

    def check_progress_taverna
      # necessary setup
      server = "http://172.24.13.85:8080/TavernaServer.2.2a1"
      baseurl = "rest/runs"
      jobid = self.parameters['jobid']
      url = "#{server}/#{baseurl}/#{jobid}/status"
      tmpdir = "/tmp/taverna/"
      begin
        unless Dir.exists?(tmpdir)
          FileUtils.mkdir_p(tmpdir)
        end
      rescue

      end

      # make the connection
      resource = RestClient::Resource.new url
      response = resource.get
      status = response.body

      if status == 'Operating'
        if self.check_count >= 10
          # perhaps failed

          return
        else
          # give some extra time

          return
        end
      elsif status == 'Finished'
        # try to get output files
        url = "#{server}/#{baseurl}/#{jobid}/wd/out"
        resource = RestClient::Resource.new url
        response = resource.get
        config = XmlSimple.xml_in(response.body)

        # this is to parse each entry in the xml that's returned from the output
        # query, and to create files and subdirectories
        config.each_pair do |k,v|
          if k == 'dir'
            v.each do |entry|
              FileUtils.mkdir_p(entry['content'])
            end
          elsif k == 'file'
            v.each do |entry|
              content = File.path(entry['content'])
              path = content.gsub(/\/#{File.basename(content)}$/,"")
              unless Dir.exists?(path)
                FileUtils.mkdir_p(path)
              end
              system("cd #{path} && wget #{entry['xlink:href']}")
            end
          end
        end 

        # now zip these up and load them into the database
        begin
        system("cd #{tmpdir}  && zip -r #{self.id}.zip #{self.id}")
          FileUtils.rm_r "#{tmpdir}/#{self.id}"
          self.outfile = File.open("#{tmpdir}/#{self.id}.zip")
          self.status = 'finished'
          self.save
          File.delete("#{tmpdir}/#{self.id}.zip")

        rescue
          jobfail("Count not acquire job output","could not acquire job output")
          return
        end

      else
        # WTF?
      end

    end
  end
end
