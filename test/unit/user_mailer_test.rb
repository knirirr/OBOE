require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  setup do
    @default = FactoryGirl.create(:account, :name => 'Default')
    @user = FactoryGirl.create(:user)
    @job = FactoryGirl.create(:job)
    @from = "noreply.oboe@oerc.ox.ac.uk"
  end

  test "job ready" do
    @user.account = @default.id
    Rails.logger.info("User: #{@user.email}, #{@user.account}")
    @user.confirm!
    response = UserMailer.job_ready(@user,@job).deliver
    assert_equal "Your #{Job.types.invert[@job.type]} analysis has completed", response.subject
    assert_match /#{@job.blurb_win}/, response.body.to_s
    assert_equal @user.email, response.to[0] 
  end

  test "job failed" do
    @user.account = @default.id
    Rails.logger.info("User: #{@user.email}, #{@user.account}")
    @user.confirm!
    response = UserMailer.job_failed(@user,@job).deliver
    #assert_equal "Your #{Job.types.invert[@job.type]} analysis has failed", response.subject
    assert_equal "Your #{@job.type} analysis has failed", response.subject
    assert_match /#{@job.blurb_fail}/, response.body.to_s
    assert_equal @user.email, response.to[0] 
  end

  test "send left logs" do
    # fill this in later
    # obsolete, I think
  end

  test "new user" do
    response = UserMailer.new_user(@user).deliver
    assert_equal "New user created: #{@user.email}", response.subject
    assert_equal @from, response.from[0]
  end




end

__END__

