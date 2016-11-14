FactoryGirl.define do
  factory :job do
    type 'test'
    status 'new'
    job_name 'A New Job'
    job_description 'used for testing'
    email 'milo.thurston@oerc.ox.ac.uk'
  end
end

#Factory.define :job do |j|
#  j.sequence(:inputurl) {|n| "http://input/#{n}" }
#  j.type 'test'
#  j.status 'new'
#  j.email 'milo.thurston@oerc.ox.ac.uk'
#end
