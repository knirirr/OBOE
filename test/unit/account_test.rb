require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  setup do
    @account = FactoryGirl.create(:account, :name => 'Default')
    @dropdir = "/storage/oboe/Jobs"
    @types = Job.maptypes
  end

  test "create new account" do
    # check that all defaults are set propery
    assert_equal(@account.credits['test'], 0)
    assert_equal(@account.totals['test'], 0)
    assert_equal(@account.expiry['test'], '31/06/2017')
    assert_equal(@account.arrears['test'], 'yes')
  end

  test "add new job" do
    # all defaults must be set properly
    @account.new_job('new')
    assert_equal(@account.credits['new'], 0)
    assert_equal(@account.totals['new'], 0)
    assert_equal(@account.expiry['new'], '31/06/2017')
    assert_equal(@account.arrears['new'], 'yes')
  end

  test "read hosts files" do
    @types.each do |t|
      assert_equal(true, File.exists?("#{@dropdir}/#{t}/hosts.txt"))
    end
  end

end
