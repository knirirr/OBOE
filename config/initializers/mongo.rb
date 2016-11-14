MongoMapper.connection = Mongo::ReplSetConnection.new(['172.24.13.83:27017','172.24.13.82:27017','172.24.13.81:27017','172.24.13.84:27017'], :read_secondary => false, :name => 'vibrant')
'host:port'
MongoMapper.database = "vibrant_#{Rails.env}"
pass = IO.readlines("/etc/conf.d/mongo_password")[0].chomp.split(":")
MongoMapper.database.authenticate(pass[0], pass[1])

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
