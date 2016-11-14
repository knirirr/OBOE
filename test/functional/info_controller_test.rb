require 'test_helper'

class InfoControllerTest < ActionController::TestCase

  test "should get welcome" do
    get :welcome
    assert_response :success
  end

  test "should get routes" do
    @user = FactoryGirl.build(:user)
    @user.confirm!
    sign_in @user
    get :routes
    assert_response :success
  end

  test "should get docs" do
    @user = FactoryGirl.build(:user)
    @user.confirm!
    sign_in @user
    get :docs
    assert_response :success
  end

  test "not logged in" do
    get :routes
    assert_response :redirect
  end


  #test "should fail to get routes" do
  #  @request.env['REMOTE_ADDR'] = '10.0.0.1'
  #  get :routes
  #  assert_equal "Not allowed.", @response.body
  #end
end

