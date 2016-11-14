class Account
  include MongoMapper::Document

  key :name, String
  key :credits, Hash, :required => true
  key :expiry, Hash, :required => true
  key :totals, Hash, :required => true
  key :arrears, Hash, :required => true
  key :users, Array, :required => false
  timestamps!

  attr_accessor :name, :credits
  # default values
  before_validation :set_defaults, :on => :create

  def set_defaults
    self.credits = {}
    self.totals = {}
    self.expiry = {}
    self.arrears = {}
    Job.types.each_value do |v|
      self.credits[v] = 0
      self.totals[v] = 0
      self.expiry[v] = '31/06/2017'
      self.arrears[v] = 'yes'
    end
    return true
  end

  # add a new type to each account when it is added to the
  # application, using the console...
  # use a loop here...
  def new_job(type)
    self.credits[type] = 0
    self.totals[type] = 0
    self.expiry[type] = '31/06/2017'
    self.arrears[type] = 'yes'
  end

  # delete an entry, e.g. if job removed or renamed
  def del_job(type)
    self.credits.delete(type)
    self.totals.delete(type)
    self.expiry.delete(type)
    self.arrears.delete(type)
  end


  # recursive search of the jobs directory to find which jobs are running
  # on which machines
  # this should be in the job.rb file but there's a problem with the joint plugin
  def self.hostcheck(type)
    dropdir = "/storage/oboe/Jobs"
    hosts = Hash.new
    begin
      IO.readlines("#{dropdir}/#{type}/hosts.txt").each do |h|
        h.chomp!
        hosts[h] = Dir["#{dropdir}/**/*#{h}*"].length || 0
      end
      choice = hosts.sort {|a,b| a[1] <=> b[1]}[0][0] || "no_servers"
      return choice 
    rescue
      return "no_servers"
    end
  end

end
