class Job
  module DurdenExtension
    def process_new_durden
     # this job will take an uploaded file and dump it on an nfs-mounted cockatrice directory,
      # from where a cron job will process it
      durdir = "/storage/durden"
      begin
        FileUtils.mkdir_p("#{durdir}/#{self.id}")
      rescue
        jobfail("Could not prepare output directory","output directory preparation failed")
        return
      end
      # if it's not defined or isn't an int then this should fail and set it
      # to the default
      begin
        tile_size = Integer(self.parameters['tile_size'])
      rescue
        tile_size = 256 
      end
      execute = "#{self.inputurl.gsub(/\s/,"%20")} #{self.id} #{tile_size}\n"
      begin
        File.open("#{durdir}/process.txt","a") {|f| f.write(execute) }
      rescue
        jobfail("Could not prepare input files","input file preparation failed")
        return
      end
      self.update_attributes(:status =>'in progress')
      CheckingWorker.perform_at(10.minutes.from_now, self.id)
    end

    def check_progress_durden
      durdir = "/storage/durden"
      if File.exists?("#{durdir}/#{self.id}.finished")
        begin
          self.proper_outfilename = "#{self.id}.zip"
          self.status = 'finished'
          self.save
          system("touch #{durdir}/#{self.id}.delete")
        rescue
         jobfail("Could not acquire job output","could not acquire job output")
         return
        end
        user = User.find_by_email(self.email)
        UserMailer.job_ready(user,self).deliver 
      elsif File.exists?("#{durdir}/#{self.id}.fail")
       jobfail("Could not run Durden","could not run durden")
       return
      else
        CheckingWorker.perform_at(10.minutes.from_now, self.id)
      end 
    end
  end
end
