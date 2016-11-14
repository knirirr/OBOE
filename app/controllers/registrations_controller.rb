class RegistrationsController < Devise::RegistrationsController

  def create
    if verify_recaptcha
      super
      logfile = "#{Vibrant::Application.config.dropbox}/oboe_users_#{Rails.env}.txt"
      begin
        open(logfile, 'a') do |f|
          f.puts "#{resource.email},#{request.ip},#{resource.created_at}"
        end
      rescue
        Rails.logger.error("Could not write to user file!")
      end
    else
      build_resource
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      flash.delete :recaptcha_error
      render :new
    end
  end

  # destroy all user's jobs if their account is deleted
  def destroy
    # first find the users and set their accounts back to default
    jobs = Job.all(:email => current_user.email)
    jobs.each do |j|
      j.destroy
    end

    # now the account may be safely destroyed
    current_user.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'jobs', :action => 'index' }
      format.json { head :ok }
    end
  end

end
