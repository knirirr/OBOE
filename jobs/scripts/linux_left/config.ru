require 'sinatra'

set :env,  :production
disable :run

require './left_webapp.rb'    #the app itself

run Sinatra::Application
