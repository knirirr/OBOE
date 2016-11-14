FactoryGirl.define do
  factory :user do
    email 'milo.thurston@oerc.ox.ac.uk'
    password 'password'
    password_confirmation 'password'
  end
end
