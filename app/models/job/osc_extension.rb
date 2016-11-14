class Job
  module OscExtension
    # all OSC jobs have the same type of status check, which is to see if the job is still in the queue
    # and if it isn't, to assume it's finished and grab all the output files
    def check_osc_job
      # qstat must be queried on the remote server 
      begin
        parts = self.vars[:oscid].split(/\./)
        oscid = parts[0] + "." + parts[1]
        stat = `ssh oboe@#{$osc_host}.#{$osc_domain} qstat -u oboe | grep #{oscid}`
      rescue
        Rails.logger.info("Could not connect to #{$osc_host}: #{self.id}")
        return
      end
      if stat == "" # finished
        # remote directory needs to be re-mounted in order to grab the
        # output
        remote_dir = '/data/vibrant/oboe'
        local_dir = "#{Rails.root}/tmp/data"
        begin
          system("scp -r oboe@#{$osc_host}.#{$osc_domain}:#{remote_dir}/#{self.id} #{local_dir}")
          File.unlink("#{local_dir}/#{self.id}/#{self.id}.sh")
          system("cd #{local_dir} && zip -r #{self.id}.zip #{self.id}") # needs testing again
          self.outfile = File.open("#{local_dir}/#{self.id}.zip") 
          self.proper_outfilename = "#{self.id}.zip"
          self.status = 'finished'
          self.save
          FileUtils.rm_r("#{local_dir}/#{self.id}")
          File.unlink("#{local_dir}/#{self.id}.zip") 
          user = User.find_by_email(self.email)
          UserMailer.job_ready(user,self).deliver 
        rescue
          self.jobfail("Failed to get data for","could not get data")
          return
        end
      else
        Rails.logger.info("About to check: #{self.id}")
        CheckingWorker.perform_at(1.hour.from_now, self.id)
        Rails.logger.info("Checked: #{self.id}")
      end
    end
  end
end
