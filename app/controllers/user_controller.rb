class UserController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_allowed, :only => [:show_token,:change_token]
  layout :resolve_layout

  # a couple of methods for showing server admins
  # their auth token and letting them change it
  def show_token
    @token = current_user.authentication_token
    if @token.nil?
      flash[:alert] = "Token not available."      
      redirect_to :controller => 'info', :action => 'welcome'
    end
  end

  def change_token
    @user = current_user
    if @user.authentication_token.nil?
      flash[:alert] = "Action not allowed."      
      redirect_to :controller => 'info', :action => 'welcome' and return
    end
    @user.reset_authentication_token 
    if @user.save
      flash[:notice] = "Token changed."      
      redirect_to :controller => 'user', :action => 'show_token'
    else
      flash[:alert] = "Failed to change token."      
      redirect_to :controller => 'info', :action => 'welcome' 
    end

  end

  # a means for admins to see all jobs on the system
  def list_users
    if !current_user.admin?
      redirect_to :jobs and return
    end

    @users = User.paginate :page => params[:page], :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
      format.json  { render :json => @jobs }
    end

  end

  def find_users
    if !current_user.admin?
      redirect_to :jobs and return
    end
    if request.post?
      begin
        re = Regexp.new(Regexp.escape(params[:email]), 'i')
        @users = User.all(:email => re)
      rescue
        flash[:alert] = "User not found"
        redirect_to '/users/find'
      end
    end
  end

  # edit a single user in order to add them to a group,
  # and so on...
  def show_user
    if !current_user.admin?
      redirect_to :jobs and return
    end
    @user = User.find(params[:id])
    if request.post?
      # process the form and save the user
      begin
      @account = Account.find(params[:account][:id])
      old_account = Account.first(:users => @user.id)
      old_account.users.delete(@user.id)
      old_account.save!
      @account.users << @user.id
      @account.users.uniq!
      @user.account = @account.id
      rescue
        Rails.logger.error("Failed to change account for user: #{@user.id}")
        redirect_to :controller => '/user', :action => 'show_user', :id => @user.id
        return
      end
      # This should be a unique key if I understand the mongo_mapper documentation
      # correctly, but it seems happy to have the same value inserted multiple times.
      # I'm damned if I know why...
      if @account.save! and @user.save!
        flash[:notice] = "Account updated successfully!"
      else
        flash[:alert] = "Error updating account!"
      end
      redirect_to :controller => '/user', :action => 'show_user', :id => @user.id
    else
      @account = Account.first(:users => @user.id)
    end
  end

  
  def stats
    if !current_user.admin?
      redirect_to :jobs and return
    end
    # find all users and count how many jobs they've done
    @output = Hash.new
    users = User.all
    Job.types.each {|k,v| 
      value = 0
      users.each do |u|
        if u.runs[v].blank?
          u.runs[v] = 0
        else
          value += u.runs[v]        
        end
      end
      @output[k] = value
    } 
  end

end
