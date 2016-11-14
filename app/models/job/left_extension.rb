class Job
  module LeftExtension
    def process_new_left
      Rails.logger.info("I'm about to process left job #{self.id}")

      # the coordinates may be stored as a proper coordinate string or by 
      # four simple values supplied by simple users. Here one converts
      # the latter into the former
      user = User.find_by_email(self.email)
      coordinates = self.parameters[:coords].gsub(/\r\n?/, "")

      # create the args.txt needed by the compiled left job
      outstring = 
"\"coords\",\"#{coordinates}\",\n\
\"jobid\",\"#{self.id}\",\n\
\"jobdescription\",\"#{self.job_description}\",\n\
\"jobtitle\",\"#{self.job_name}\",\n\
\"jobsubmitter\",\"#{self.email}\",\n\
\"location\",\"yes\",\n\
\"streetmap\",\"yes\",\n\
\"globcover\",\"yes\",\n\
\"ecoregions\",\"yes\",\n\
\"speciesrecords\",\"yes\",\n\
\"betadiversity\",\"yes\",\n\
\"vulnerability\",\"yes\",\n\
\"fragmentation\",\"yes\",\n\
\"migratoryspecies\",\"yes\",\n\
\"hydrosheds\",\"yes\",\n\
\"resilience\",\"yes\",\n\
\"summary\",\"yes\"\n"


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
        self.jobfail("Could not write files for left job ","files not written")
        return
      end

      # get the name of the server which is to analyse this job
      choice = Account.hostcheck(self.type)

      # then, create a zipfile and put it in the dropbox dir
      dropdir = "#{Vibrant::Application.config.dropbox}/left"
      begin
        out = `cd /tmp && zip -r #{self.id}.#{choice}.zip #{self.id}`
        FileUtils.mv "/tmp/#{self.id}.#{choice}.zip", "#{dropdir}"
        system("chmod 777 #{dropdir}/#{self.id}.#{choice}.zip")
        FileUtils.rm_r tmpdir
      rescue
        self.jobfail("Could not prepare zip for left job ","zip creation failure")
        return
      end

      # then:
      self.update_attributes(:status =>'in progress')

      # start a checking process for 30 minutes from now
      self.update_attributes(:vars => {:checked => 0})
      CheckingWorker.perform_at(15.minutes.from_now, self.id)
  
      # let neil know that a LEFT job has been started
      #UserMailer.left_running(self).deliver 
    end

    def check_progress_left
      dropdir = "#{Vibrant::Application.config.dropbox}/left"
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
          return
        rescue
          self.jobfail("Zip handling failed for ","could not process outfile")
          return
        end
      else 
        # still running
        case self.vars['checked']
        when 0..2
          self.checkup
          CheckingWorker.perform_at(5.minutes.from_now, self.id)
        when 3..4
          self.checkup
          CheckingWorker.perform_at(15.minutes.from_now, self.id)
        when 5..6
          self.checkup
          CheckingWorker.perform_at(30.minutes.from_now, self.id)
        else
          CheckingWorker.perform_at(60.minutes.from_now, self.id)
        end
      end
    end

    def checkup
      self.update_attributes(:vars => {:checked => self.vars['checked'] + 1})
    end
  end
end
