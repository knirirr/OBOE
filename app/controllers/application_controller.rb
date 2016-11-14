class ApplicationController < ActionController::Base
  before_filter :check_for_maintenance
  layout :resolve_layout
  protect_from_forgery

  # users allowed to see the documentation and routes  
  begin    
    $allowed_users = IO.readlines("#{Rails.root}/allowed_users").to_a.collect {|x| x.chomp!}  
  rescue    
    $allowed_users = Array.new    
    Rails.logger.error("#{Rails.root}/allowed_users is missing.")  
  end

  private


  # only certain users to see these docs
  def check_allowed
    unless $allowed_users.include?(current_user.email)
      flash[:alert] = "That information is not available."
      redirect_to :action => 'welcome', :controller => 'info'
    end
  end

  def check_user(job)
    if job.email == current_user.email
      return true
    elsif current_user.admin?
      return true
    else
      return false
    end
  end

  def admin_only
    if current_user.admin?
      return true
    end
    flash[:alert] = "That information is not available."
    redirect_to :action => 'welcome', :controller => 'info'
  end

  def check_for_maintenance
    if File.exists? "#{Rails.root.to_s}/maintenance.html"
      render( :file =>  "#{Rails.root.to_s}/maintenance.html")
      return
    end
  end

  def resolve_layout
    case action_name
    when "routes","docs","parameters"
      nil
    else
      "oboe"
    end
  end

end

