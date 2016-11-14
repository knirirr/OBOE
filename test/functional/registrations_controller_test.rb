require 'test_helper'
#require File.dirname(__FILE__) + '/../test_helper'
class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

=begin
  setup do
    @user = FactoryGirl.create(:user)
    @job = FactoryGirl.create(:job)
    @user.confirm!
    sign_in @user
  end

  test "should delete user and job" do
    assert_difference(Job.count,-1) do
      delete :destroy, :id => @user.to_param
      assert_response :success
    end
  end
=end

end
