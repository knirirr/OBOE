class StartingWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(job_id)
    job = Job.find(job_id)
    if job.process_new
      spend_credits(User.first(:email => job.email).account,job.type)
    else
      Rails.logger.error("Sidekiq submission for job #{job_id} failed")
    end
  end

  def spend_credits(account_id, type)
    account = Account.find(account_id)
    currcred = account.credits[type].to_i 
    currcount = account.totals[type].to_i
    Rails.logger.info("Account #{account.id}: #{type} #{currcred} => #{currcred - 1}")
    account.credits[type] = currcred - 1
    account.totals[type] = currcount + 1
    if account.save!
      Rails.logger.info("Account #{account.id} saved!")
    end
  end

end
