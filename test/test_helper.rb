ENV["RAILS_ENV"] = "test"
#require File.expand_path('../../config/environment', __FILE__)
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'
require 'factory_girl'

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  # Drop all collections after each test case.
  def teardown
    MongoMapper.database.collections.each do |coll|
      unless coll.name =~ /system/
        coll.remove 
      end
    end
  end

  # Make sure that each test case has a teardown
  # method to clear the db after each test.
  def inherited(base)
    base.define_method teardown do 
      super
    end
  end
end
