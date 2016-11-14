class Job
  module BictExtension
    def process_new_bict
      Rails.logger.info("I'm about to process bict job #{self.id}")

      # create outstring for args.txt
      outstring = 
"\"infile\",\"#{self.inname}\",\n\
\"jobid\",\"#{self.id}\",\n\
\"jobdescription\",\"#{self.job_description}\",\n\
\"jobtitle\",\"#{self.job_name}\",\n\
\"jobsubmitter\",\"#{self.email}\"\n"

      # create the directory structure for the zip file which will be
      # sent to the shared directory
      tmpdir = "/tmp/#{self.id}"
      begin
        FileUtils.mkdir_p("#{tmpdir}/input/data")
        File.open("#{tmpdir}/input/args.txt","w") {|f| f.write(outstring) }
        File.open("#{tmpdir}/input/data/#{self.inname}","w") {|f| f.write(self.infile.read.force_encoding('UTF-8')) }
      rescue
        self.jobfail("Could not write files for bict job ","files not written")
        return
      end

      # run the indices code on the input file
      if self.parameters['analysis_type'] == 'bqif'
        exepath = "#{Rails.root}/jobs/bict/BICT.indices/indices.BQI.family"
        flags = "-f" 
        exe = "indexBQIfam"
      else
        exepath = "#{Rails.root}/jobs/bict/BICT.indices/indices"
        flags = "-b -x -a"
        exe = "indices"
      end
      choice = Account.hostcheck(self.type)
      dropdir = "#{Vibrant::Application.config.dropbox}/bict"
      begin
        # run the C code
        out = `cd #{exepath} && #{exepath}/#{exe} /tmp/#{self.id}/input/data/#{self.inname} /tmp/#{self.id}/input/data/#{self.id}.in.csv #{flags} > /tmp/#{self.id}/input/data/#{self.id}.in.txt 2>&1`

        # zip all the files
        out = `cd /tmp && zip -r #{self.id}.#{choice}.zip #{self.id}`
        FileUtils.mv "/tmp/#{self.id}.#{choice}.zip", "#{dropdir}"
        system("chmod 777 #{dropdir}/#{self.id}.#{choice}.zip")
        FileUtils.rm_r tmpdir
      rescue
        self.jobfail("Could not prepare zip for bict job ","zip creation failure")
        return
      end

      # then:
      self.update_attributes(:status =>'in progress')

      # start a checking process for 30 minutes from now
      CheckingWorker.perform_at(15.seconds.from_now, self.id) 

    end

    def check_progress_bict
      dropdir = "#{Vibrant::Application.config.dropbox}/bict"
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
        CheckingWorker.perform_at(30.seconds.from_now, self.id)
      end
    end

  end
end
