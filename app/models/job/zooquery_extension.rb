class Job
  module ZooqueryExtension
    def process_new_zooquery
      require 'csv'
      Rails.logger.info("I'm about to process zooquery job #{self.id}")
      jobdir = "/storage/oboe/Jobs/zooquery"
      config_file = "#{Rails.root}/config/rds.yml"
      
      # read the configuration
      begin 
        config = YAML::load(IO.read(config_file))
      rescue
        jobfail("Couldn't read database connection info","can't read database config")
        return
      end


      # establish the connection
      begin
        conn = PG::Connection.new(:host => config['host'],
                                  :port => config['port'],
                                  :dbname => config['dbname'],
                                  :user => config['ro_user'],
                                  :password => config['ro_password'])
      rescue
        jobfail("Couldn't establish connection","no database connection")
        return
      end

      # stream the data
      begin
        # select the data into a csv file
        io = File.open("#{jobdir}/#{self.id}.csv","w")
        csv = CSV.new(io, :col_sep => (1).chr)
        conn.exec(self.parameters['sql']) do |s|
          s.each_row do |r|
            csv << r
          end
        end
        csv.close
      rescue PG::Error => e
        jobfail("SQL error: #{e}","SQL error: #{e}")
        return
      rescue
        jobfail("Couldn't get data","couldn't get data") # so there!
        return
      ensure
        conn.close
      end

      # zip up the output
      begin
        system("cd #{jobdir} && zip #{self.id}.zip #{self.id}.csv")
        File.unlink("#{jobdir}/#{self.id}.csv")
        self.status = "finished"
        self.save
        user = User.find_by_email(self.email)
        UserMailer.job_ready(user,self).deliver
      rescue
        jobfail("Error processing outfile","error processing outfile")
        return
      end

    end

    def check_progress_zooquery
      # no response here
    end

    # some more stuff must go here in order to control the 
    # redshift cluster...
    # ...or whatever other database we end up using
  end
end
