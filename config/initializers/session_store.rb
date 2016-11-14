# Be sure to restart your server when you modify this file.

Vibrant::Application.config.session_store :cookie_store, :key => '_vibrant_oerc_session'

# Use the database for sessions instead of the cookie-based default, which 
# shouldn't be used to store highly confidential information (create the session 
# table with "rails generate session_migration")

#require "mongo_session_store/mongo_mapper"
#Vibrant::Application.config.session_store :mongo_mapper_store
#ActionController::Base.session_store = :mongo_mapper_store
