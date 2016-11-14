desc "Delete jobs more than a month old"
task :delete_old => :environment do
  jobs = Job.all(:conditions => {:created_at.lt => (Time.now - 2.628e006)})
  Rails.logger.info("Deletion of #{jobs.length} old jobs started: #{Time.now}") # need to log this properly
  jobs.each do |j|
    begin
      j.destroy
      Rails.logger.info("#{j.type} job #{j.id} deleted.") # need to log this properly
    rescue
      Rails.logger.error("Job #{j.id} could not be deleted.")
    end
  end
  Rails.logger.info("Job deletion finished: #{Time.now}") # need to log this properly
end
