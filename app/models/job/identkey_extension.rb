class Job
  module IdentkeyExtension
    def process_new_identkey
      # executed immediately, so no check_progress
     # N.B. this works like the test job above in that it is executed immediately 
      # and does not have any need of a check_progress method
      webservice_hostname = "172.24.13.84" # voonith
      service_url = "http://#{webservice_hostname}:8080/IK_WS_REST-1.0/identificationKey"
      begin
        response = RestClient.post service_url, :sddURL => self.inputurl, :format => self.parameters['format'], :representation => self.parameters['representation'],  :fewStatesCharacterFirst => self.parameters['few'], :mergeCharacterStatesIfSameDiscimination => self.parameters['merge'], :pruning => self.parameters['pruning'], :verbosity => self.parameters['verbosity'], :scoreMethod => self.parameters['score']
        # the key service will return a text file with an error in it
        # in such instances as the input URL being wrong
        # There's a bug with openuri here which prevents the output file being downloaded
        # and so I won't bother
        if response =~ /error/
          self.jobfail("Key service returned an error ","key service failure")
          return 
        end
        uri = URI.parse(response)
        self.outfile = open(uri)
        self.proper_outfilename = response.split(/\//).to_a[-1]
        self.parameters['keyurl'] = response
        # if we got here then it should have worked
        self.status = 'finished'
        self.save
      rescue
        self.jobfail("Job could not run ","execution failed")
        return
      end
    end

    def check_progress_identkey
      # nothing to see here
    end
  end
end
