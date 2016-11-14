class Job
  module MuscleExtension
    def process_new_muscle
     url = "http://www.ebi.ac.uk/Tools/services/rest/muscle/run/"
      begin
        response = RestClient.post url,  :email => $admin_email, :title => self.job_name, :format => self.parameters['format'], :tree => self.parameters['tree'], :order => self.parameters['order'], :sequence => self.infile.read.force_encoding('UTF-8')
        self.parameters['identifier'] = response.body
        self.status = 'in progress'
        self.save
        CheckingWorker.perform_at(20.minutes.from_now, self.id)
      rescue
        jobfail("Could not submit to EBI","submission to remote server failed")
        return
      end
    end

    def check_progress_muscle
      url = "http://www.ebi.ac.uk/Tools/services/rest/muscle/status/#{self.parameters['identifier']}"
      resource = RestClient::Resource.new url
      response = resource.get
      status = response.body
      case status
      when 'RUNNING' # the job is currently being processed.
        CheckingWorker.perform_at(20.minutes.from_now, self.id)
        return
      when 'FINISHED' # job has finished, and the results can then be retrieved.
        # get all types, save them to temp file, zip up and suck into database
        begin
          tmpdir = "/tmp"
          unless Dir.exists?("#{tmpdir}/#{self.id}")
            FileUtils.mkdir_p("#{tmpdir}/#{self.id}") 
          end
        rescue
         jobfail("Could not prepare output dirs","could not prepare output")
         return
        end
        begin
          url = "http://www.ebi.ac.uk/Tools/services/rest/muscle/resulttypes/#{self.parameters['identifier']}"
          resource = RestClient::Resource.new url
          response = resource.get
          parameters = XmlSimple.xml_in(response.body)
          parameters['type'].each do |t|
            url = "http://www.ebi.ac.uk/Tools/services/rest/muscle/result/#{self.parameters['identifier']}/#{t['identifier'][0]}"
            resource = RestClient::Resource.new url
            response = resource.get
            clu = File.open("#{tmpdir}/#{self.id}/#{t['identifier'][0]}.#{t['fileSuffix'][0]}","w")
            clu.write response.body
            clu.close
          end
          out = `cd /tmp && zip -r #{self.id}.zip #{self.id}`
          self.outfile = File.open("#{tmpdir}/#{self.id}.zip") 
          self.proper_outfilename = "#{self.id}.zip"
          self.status = 'finished'
          self.save
          FileUtils.rm_r("#{tmpdir}/#{self.id}")
          File.unlink("#{tmpdir}/#{self.id}.zip") 
          user = User.find_by_email(self.email)
          UserMailer.job_ready(user,self).deliver 
        rescue
         jobfail("Could not download output","could not download output")
         return
        end
      when 'ERROR' # an error occurred attempting to get the job status.
         if self.parameters['retries'].nil?
           self.parameter['retries'] = 1
         elsif self.parameters['retries'] >= 5
          jobfail("EBI tries exceeded","check failed after #{self.parameters['retries']} attempts")
          return
         end
         self.parameters['retries'] += 1
      when 'FAILURE' # the job failed.
        jobfail("EBI reports fail","remote server reports failure")
        return
      when 'NOT_FOUND' # the job cannot be found.
        jobfail("EBI reports missing","remote server can\'t find job")
        return
      end
    end
  end
end
