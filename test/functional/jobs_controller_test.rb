require 'test_helper'
#require File.dirname(__FILE__) + '/../test_helper'
class JobsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @default = FactoryGirl.create(:account, :name => 'Default')
    @user = FactoryGirl.create(:user)
    @user.confirm!
    sign_in @user
  end

  test "should get index" do
    @user.account = @default.id
    Rails.logger.info("User: #{@user.email}, #{@user.account}")
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end


  test "should create and destroy job" do
    assert_equal 0, Job.count
    @job = FactoryGirl.create(:job)
    assert_equal(Job.count,1) do
      post :create, :job => @saved_job.attributes
    end
    assert_response :success

    assert_difference('Job.count', -1) do
      delete :destroy, :id => @job.to_param
    end
    assert_redirected_to jobs_path

  end

  test "should show job" do
    @job = FactoryGirl.create(:job)
    get :show, :id => @job.to_param
    assert_response :success
  end

  test "should get edit" do
    @job = FactoryGirl.create(:job)
    get :edit, :id => @job.to_param
    assert_response :success
  end

  test "should update job" do
    @job = FactoryGirl.create(:job)
    put :update, :id => @job.to_param, :job => @job.attributes
    assert_redirected_to job_path(assigns(:job))
  end

  test "should fail to destroy job" do
    @job = FactoryGirl.create(:job, :email => 'neil.caithness@oerc.ox.ac.uk')
    delete :destroy, :id => @job.to_param
    assert_redirected_to jobs_path
  end

  test "should find my job" do
    @job = FactoryGirl.create(:job)
    get :search, :user => @job.user
    assert_response :success
  end

  test "sign out" do
    sign_out @user
    assert_response :success
  end

  # the tests below are dodgy - I have no idea how to get the first to work

  #test "fail to view private job" do
  #  sign_out @user
  #  @job = FactoryGirl.create(:job, :public => false, :email => 'neil.caithness@oerc.ox.ac.uk')
  #  get :show, :id => @job.to_param
  #  puts "RESPONSE: #{@response.class}"
  #  puts "BODY: #{@response.body}"
  #  assert_select  "login_form"
  #end

  test "view public job" do
    @job = FactoryGirl.create(:job, :public => true)
    get :show, :id => @job.to_param
    assert_response :success
  end

end
