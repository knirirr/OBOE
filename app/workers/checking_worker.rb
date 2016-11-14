class CheckingWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(job_id)
    job = Job.find(job_id)
    job.check_progress
  end


end
