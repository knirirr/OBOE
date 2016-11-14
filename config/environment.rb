# Load the rails application
require File.expand_path('../application', __FILE__)

module Vibrant
  class Application < Rails::Application
    config.dropbox = "/storage/oboe/Jobs"
  end
end

# Initialize the rails application
Vibrant::Application.initialize!
