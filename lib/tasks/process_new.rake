desc "Process pending jobs"
task :process_new => :environment do
  jobs = Job.all(:status => 'new')
  #Rails.logger.info("Job processing started: #{Time.now}") # need to log this properly
  jobs.each do |j|
    #Rails.logger.info("Job #{j.id} is a #{j.type} job.") # need to log this properly
    begin
      j.process_new
    rescue
      Rails.logger.error("Job #{j.id} could not be processed.")
    end
  end
  #Rails.logger.info("Job processing finished: #{Time.now}") # need to log this properly
end
