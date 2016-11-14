class Job
  module LccExtension
    def process_new_lcc
      Rails.logger.info("I'm about to process lcc job #{self.id}")

      # the coordinates may be stored as a proper coordinate string or by 
      # four simple values supplied by simple users. Here one converts
      # the latter into the former
      user = User.find_by_email(self.email)
      coordinates = self.parameters[:coords].gsub(/\r\n?/, "")

      # create the args.txt needed by the compiled lcc job
      outstring = 
"\"coords\",\"#{coordinates}\",\n\
\"jobid\",\"#{self.id}\",\n\
\"jobdescription\",\"#{self.job_description}\",\n\
\"jobtitle\",\"#{self.job_name}\",\n\
\"jobsubmitter\",\"#{self.email}\"\n"

      # first, it is necessary to create the directory structure
      tmpdir = "/tmp/#{self.id}"
      FileUtils.mkdir_p("#{tmpdir}/input")
      begin
        File.open("#{tmpdir}/input/args.txt","w") {|f| f.write(outstring) }
      rescue
        self.jobfail("Could not write files for lcc job ","files not written")
        return
      end

      # get the name of the server which is to analyse this job
      choice = Account.hostcheck(self.type)

      # then, create a zipfile and put it in the dropbox dir
      dropdir = "#{Vibrant::Application.config.dropbox}/lcc"
      begin
        out = `cd /tmp && zip -r #{self.id}.#{choice}.zip #{self.id}`
        FileUtils.mv "/tmp/#{self.id}.#{choice}.zip", "#{dropdir}"
        system("chmod 777 #{dropdir}/#{self.id}.#{choice}.zip")
        FileUtils.rm_r tmpdir
      rescue
        self.jobfail("Could not prepare zip for lcc job ","zip creation failure")
        return
      end

      # then:
      self.update_attributes(:status =>'in progress')
      CheckingWorker.perform_at(1.minutes.from_now, self.id)
      self.update_attributes(:vars => {:checked => 0})
    end

    def check_progress_lcc
      dropdir = "#{Vibrant::Application.config.dropbox}/lcc"
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
        case self.vars['checked']
        when 0..3
          self.checkup
          CheckingWorker.perform_at(1.minutes.from_now, self.id)
        when 4..6
          self.checkup
          CheckingWorker.perform_at(5.minutes.from_now, self.id)
        else
          CheckingWorker.perform_at(15.minutes.from_now, self.id)
        end
      end
    end

    def checkup
      self.update_attributes(:vars => {:checked => self.vars['checked'] + 1})
    end

  end
end
