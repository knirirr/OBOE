class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all.sort {|x,y| x.name <=> y.name}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])
    @users = Array.new
    len = @account.users.length
    if len > 0
      0.upto(len -1) do |i|  
        u = User.find(@account.users[i])
        @users << u
      end
    end

    @selectopts = {}
    Job.types.each_pair do |k,v|
      if Rails.env.production?
        @selectopts[k] = v if Job.active?(v)
      else
        @selectopts[k] = v
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find(params[:id])

    # first find the users and set their accounts back to default
    default = Account.first(:name => "Default")
    @account.users.each do |u|
      begin
        user = User.find(u)
        user.account = default.id
        user.save
        default.users << user.id
      rescue
        Rails.logger.error("User #{u} cannot be found.")
      end
    end
    default.save

    # now the account may be safely destroyed
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :ok }
    end
  end

  # toggle arrears status
  # yes, I know I should be using ajax rather than re-rendering the entire page...
  def toggle_arrears
    if !current_user.admin?
      redirect_to :jobs and return
    end
    account = Account.find(params[:id])
    type = params[:type]
    if account.arrears[type] == 'no'
      account.arrears[type] = 'yes'
    elsif account.arrears[type] == 'yes'
      account.arrears[type] = 'no'
    end
    if account.save
      Rails.logger.error("SAVE succeeded")
      flash[:notice] = "#{account.name} arrears policy changed"
      redirect_to :controller => '/accounts', :action => 'show', :id => account.id
    else
      Rails.logger.error("SAVE failed")
      flash[:alert] = "#{account.name} arrears policy not changed"
      redirect_to :controller => '/accounts', :action => 'show', :id => account.id
    end
  end
end
