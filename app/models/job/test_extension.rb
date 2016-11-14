class Job
  module TestExtension
    def process_new_test
      # executed immediately, so no check_progress
      Rails.logger.info("I'm about to process test job #{self.id}")
      executable = '/usr/bin/gnuplot'
      infile = 'plot.gnuplot'
      datadir = '/home/milo/Work/Vibrant/processing' 

      # this should really be a background job and not
      # a mere system call; set this up later
      system("cd #{datadir} && #{executable} #{infile} 2> /dev/null && mv output #{self.id}.png")

      # as we're not sending the job off elsewhere then the user will be 
      # e-mailed directly that it is finished
      # finished. 
      if  File.stat("#{datadir}/#{self.id}.png").size? > 0
        begin
          self.outfile = File.open("#{datadir}/#{self.id}.png")
          self.status = 'finished'
          self.save
          user = User.find_by_email(self.email)
          File.delete("#{datadir}/#{self.id}.png")
          UserMailer.job_ready(user,self).deliver
        rescue
          Rails.logger.error("Could not copy test job #{self.id}")
          self.update_attributes(:status =>'error',:errormsg => "copying failed")
        end
      else
        self.update_attributes(:status =>'error',:errormsg => "failed to execute")
        Rails.logger.error("Failed to execute test job #{self.id}")
      end
    end

    def check_progress_test
      # no response here
    end
  end
end
