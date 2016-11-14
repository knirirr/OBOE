require 'test_helper'
 
class JobTest < ActiveSupport::TestCase

  setup do
    @job = FactoryGirl.create(:job)
    @types = Job.types
  end

  ######################
  # creating a new job #
  ######################

  test "set defaults" do
    assert_equal @job.status, 'new'
    assert_equal @job.public, false
    # more defaults
    assert_not_nil @job.parameters
    assert_not_nil @job.vars
  end

  #################
  # validating it #
  #################

  test "validate left and luc" do
    assert_raises(MongoMapper::DocumentNotValid) do
      j = FactoryGirl.create(:job, :type => 'left')
    end
    assert_nothing_raised do
      j = FactoryGirl.create(:job, :type => 'left', :parameters => ({:coords =>'1234'}))
    end
  end

  test "validate sdm" do
    assert_raises(MongoMapper::DocumentNotValid) do
      j = FactoryGirl.create(:job, :type => 'sdm')
    end
    assert_nothing_raised do
      j = FactoryGirl.create(:job, :type => 'sdm', :parameters => ({:coords =>'1234',:species => 'a list of species'}))
    end
  end

  test "validate beast" do
    assert_raises(MongoMapper::DocumentNotValid) do
      j = FactoryGirl.create(:job, :type => 'beast')
    end
    assert_nothing_raised do
      j = FactoryGirl.create(:job, :type => 'beast', :inputurl => 'http://a-url.com')
    end
  end

  ###################
  # job information #
  ###################
  
  test "info" do
    assert_not_nil Job.information
  end

  test "paramtypes" do
    @types.each_value do |t|
      assert_kind_of Hash, Job.paramtypes(t)
    end
  end

  test "form parameters" do
    @types.each_value do |t|
      if t == 'muscle'
        assert_kind_of Array, Job.form_parameters(t)
      else
        assert_kind_of Hash, Job.form_parameters(t)
      end
    end
  end

  test "can has bict executable" do
    assert_equal(true, File.exists?("#{Rails.root}/jobs/bict/BICT.indices/indices.BQI.family/indexBQIfam"))
    assert_equal(true, File.exists?("#{Rails.root}/jobs/bict/BICT.indices/indices/indices"))
  end

  ##############
  # processing #
  ##############

  test "process new" do
    # assert_respond_to( obj, symbol, [msg] )
    @types.each_value do |t|
      assert_respond_to @job, "process_new_#{t}"
    end

  end

  test "check progress" do
    @types.each_value do |t|
      assert_respond_to @job, "check_progress_#{t}"
    end
  end

  # why doesn't this return true when the files are actually there?
  test "log file exists" do
    assert_equal(true, File.exists?("/storage/oboe/Jobs/oboe_log_development.txt"))
    assert_equal(true, File.exists?("/storage/oboe/Jobs/oboe_log_production.txt"))
  end


end
