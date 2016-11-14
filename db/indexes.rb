# db/indexes.rb
Account.ensure_index [[:users, 1]], :unique => true
