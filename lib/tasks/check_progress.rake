desc "Check on running jobs"
task :check_progress => :environment do
  jobs = Job.all(:status => 'in progress')
  #Rails.logger.info("Job checking started: #{Time.now}") # need to log this properly
  jobs.each do |j|
    #Rails.logger.info("Job #{j.id} is a running job.") # need to log this properly
    begin
      j.check_progress
    rescue
      Rails.logger.error("Job #{j.id} could not be checked.")
    end
  end
  #Rails.logger.info("Job checking finished: #{Time.now}") # need to log this properly
end
