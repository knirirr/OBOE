class Job
  module SdmExtension
    def process_new_sdm
      Rails.logger.info("I'm about to process sdm job #{self.id}")

      # sdm colour: #31B369

      # the coordinates may be stored as a proper coordinate string or by 
      # four simple values supplied by simple users. Here one converts
      # the latter into the former
      user = User.find_by_email(self.email)
      coordinates = self.parameters[:coords].gsub(/\r\n?/, "")


      # create the args.txt needed by the compiled sdm job
      outstring = 
"\"coords\",\"#{coordinates}\",\n\
\"jobid\",\"#{self.id}\",\n\
\"jobdescription\",\"#{self.job_description}\",\n\
\"jobtitle\",\"#{self.job_name}\",\n\
\"jobsubmitter\",\"#{self.email}\",\n\
\"species\",\"#{self.parameters['species'].gsub(/[\n\r]+/,",")}\"\n"
      

      # first, it is necessary to create the directory structure
      tmpdir = "/tmp/#{self.id}"
      begin
        FileUtils.mkdir_p("#{tmpdir}/input/data/gbif")
        File.open("#{tmpdir}/input/args.txt","w") {|f| f.write(outstring) }
        if !self.infile.nil? 
          # this section writes out the species zip file...
          File.open("#{tmpdir}/input/data/gbif/#{self.inname}","w") {|f| f.write(self.infile.read.force_encoding('UTF-8')) }
          # ...extracts all contents...
          out = `cd #{tmpdir}/input/data/gbif/ && unzip -j #{self.inname}`
          # ...and removes the zip
          File.unlink("#{tmpdir}/input/data/gbif/#{self.inname}")
        end
      rescue
        self.jobfail("Could not write files for sdm job ","files not written")
        return
      end

      # get the name of the server which is to analyse this job
      choice = Account.hostcheck(self.type)

      # then, create a zipfile and put it in the dropbox dir
      dropdir = "#{Vibrant::Application.config.dropbox}/sdm"
      begin
        out = `cd /tmp && zip -r #{self.id}.#{choice}.zip #{self.id}`
        FileUtils.mv "/tmp/#{self.id}.#{choice}.zip", "#{dropdir}"
        system("chmod 777 #{dropdir}/#{self.id}.#{choice}.zip")
        FileUtils.rm_r tmpdir
      rescue
        self.jobfail("Could not prepare zip for sdm job ","zip creation failure")
        return
      end

      # then:
      self.update_attributes(:status =>'in progress')
      CheckingWorker.perform_at(15.minutes.from_now, self.id)
    end

    def check_progress_sdm
      dropdir = "#{Vibrant::Application.config.dropbox}/sdm"
      if File.exists?("#{dropdir}/#{self.id}.fail.zip")
        self.jobfail("Server says no for ","server reports job failed")
        self.outfile = File.open("#{dropdir}/#{self.id}.fail.zip")
        self.save
        File.unlink("#{dropdir}/#{self.id}.fail.zip")
        return
      elsif File.exists?("#{dropdir}/#{self.id}.done.zip")
        begin
          FileUtils.mv "#{dropdir}/#{self.id}.done.zip", "#{dropdir}/#{self.id}.zip"
          self.outfile = File.open("#{dropdir}/#{self.id}.zip")
          self.status = 'finished'
          self.save
          # notify of success
          user = User.find_by_email(self.email)
          UserMailer.job_ready(user,self).deliver 
          File.unlink("#{dropdir}/#{self.id}.zip")
        rescue
          self.jobfail("Zip handling failed for ","could not process outfile")
          return
        end
      else 
        # still running
        CheckingWorker.perform_at(15.minutes.from_now, self.id)
      end
    end
  end
end
