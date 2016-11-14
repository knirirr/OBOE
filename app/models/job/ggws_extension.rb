class Job
  module GgwsExtension
    $url = "http://172.24.13.84:8080/GgWS/ws"
    def process_new_ggws
      begin
        response = RestClient.post $url,  :dataFormat => self.parameters['dataFormat'], :functionName => self.parameters['functionName'], :INTERACTIVE => self.parameters['INTERACTIVE'], :data => self.parameters['data']
        callback = XmlSimple.xml_in(response.body)
        self.vars['ggws_url'] = XmlSimple.xml_in(response.body)['callback'][0]['content'].split("/")[-2]
        self.status = 'in progress'
        self.save
        CheckingWorker.perform_at(30.seconds.from_now, self.id)
      rescue
        jobfail("Could not submit to Golden Gate service","submission to remote server failed")
        return
      end
    end

    def check_progress_ggws
      begin
        resource = RestClient::Resource.new "#{$url}/#{self.vars['ggws_url']}/su"
        response = resource.get
      rescue
        jobfail("Could not connect to server","could not connect to server")
      end

      # assuming we've got the callback from the server
      callback = XmlSimple.xml_in(response.body)
      if callback['state'] == 'Running'
        CheckingWorker.perform_at(30.seconds.from_now, self.id)
        return
      elsif callback['state'] == 'Finished'
        resulturl = "#{$url}/#{self.vars['ggws_url']}/result"
        # download the result
        # joint doesn't like this. Perhaps it should be saved as a temp. file and
        # then imported? 
        #uri = URI.parse(resulturl)
        #self.infile = open(uri).read
        #self.proper_infilename = "#{self.id}.#{self.outputFormat.downcase}"
        self.vars['output'] = open(resulturl).read
        self.status = 'finished'
        self.save
        user = User.find_by_email(self.email)
        UserMailer.job_ready(user,self).deliver 
      else
        Rails.logger.error("Job #{self.id} reports dodgy callback: #{self.parameters['callback']}")
      end
    end
  end
end
