class User
  include MongoMapper::Document         

  devise :database_authenticatable, :token_authenticatable, :confirmable, :recoverable, :registerable, :rememberable, :trackable, :validatable, :lockable#, :shibboleth_authenticatable

  # jobs assigned to user, with a particular user for all the scratchpad jobs
  # only one account per user at the moment
  many :jobs

  before_validation :set_defaults, :on => :create
  before_validation :email_admin, :on => :create
  before_destroy :purge_from_account

  def set_defaults
    self.admin = false
    account = Account.first(:name => 'Default')
    self.account = account.id
    account.users << self.id
    account.save!
  end

  def purge_from_account
    account = Account.find(self.account)
    account.users.delete(self.id)
    account.save!
  end

  def email_admin
     UserMailer.new_user(self).deliver
  end

  # is the password confirmation required here? 
  key :email, String, :required => true, :unique => true
  key :admin, Boolean, :default => false
  key :runs, Hash, :required => false # how many times has a user run each type of job?
  key :notify, Boolean, :default => true # do users want to receive e-mails or not?
  key :account, String
  timestamps!

  
  # http://technicaldebt.com/?p=1089
  def self.create_indexes
    self.ensure_index(:email, :unique => true)
  end

  def allowed?(email)
    begin    
      allowed_users = IO.readlines("#{Rails.root}/allowed_users").to_a.collect {|x| x.chomp!}  
    rescue    
      allowed_users = Array.new    
      Rails.logger.error("#{Rails.root}/allowed_users is missing.")  
    end
    if allowed_users.include?(email)
      return true
    end
    return false
  end
  
end
