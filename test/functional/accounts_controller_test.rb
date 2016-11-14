require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @default = FactoryGirl.create(:account, :name => 'Default')
    @account = FactoryGirl.create(:account, :name => 'Test Account')
    @user = FactoryGirl.create(:user)
    @user.admin = true
    @user.confirm!
    sign_in @user
    Rails.logger.info("User admin status: #{@user.admin}")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, :account => {:name => 'Temp. Account'}
      assert_redirected_to account_path(assigns(:account))
    end
  end

  test "should show account" do
    get :show, id: @account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account.to_param
    assert_response :success
  end

  test "should update account" do
    put :update, id: @account.to_param, account: @account.attributes
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account.to_param
    end

    assert_redirected_to accounts_path
  end

  # set user admin to false and check that the 
  # accounts controller is blocked to them
  test "auth should fail" do
    @user.admin = false
    @user.save
    sign_out @user
    sign_in @user
    get :index
    assert_response 302
  end

end
