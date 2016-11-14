class Job
  module BeastExtension
    def process_new_beast
      Rails.logger.info("I'm about to process beast job #{self.id}")
      # first, we need to mount the remote directory in order that the necessary
      # outfiles can be written
      remote_dir = '/data/vibrant/oboe'
      local_dir = "#{Rails.root}/tmp/data"
      out_dir = "#{remote_dir}/#{self.id}"
      
      # prepare to write to file
      # N.B. -N must be truncated as PBS can't handle long names
      shortid = "oboe_#{self.id.to_s[14,10]}"
      output = <<EOF
#!/bin/bash
#PBS -V
#PBS -l walltime=120:00:00
#PBS -l nodes=1:ppn=8
#PBS -N #{shortid}

cd $PBS_O_WORKDIR
cd #{out_dir} && beast -working #{out_dir}/#{self.inname} > #{out_dir}/#{shortid}_out.txt 2> #{out_dir}/#{shortid}_err.txt

EOF

      # open and write to file
      begin
        Dir.mkdir("#{local_dir}/#{self.id}")
        # PBS submit file
        File.open("#{local_dir}/#{self.id}/#{self.id}.sh", 'w') {|f| f.write(output) }
        # BEAST XML file
        File.open("#{local_dir}/#{self.id}/#{self.inname}", 'w') {|f| f.write(self.infile.read.force_encoding('UTF-8')) }
        system("scp -r #{local_dir}/#{self.id} oboe@#{$osc_host}.#{$osc_domain}:#{remote_dir} ")
        FileUtils.rm_rf "#{local_dir}/#{self.id}"
      rescue
        self.jobfail("Could not create submission file for job ","submission file write failed")
        return
      end

      # now submit to the job queue using qsub, saving the variable returned
      # within the job so that it may be sought later with qstat
      # the reason for the versions business is in case anyone uses the version
      # parameter to inject shell commands; this should only use it if it matches
      # something from the original array
      versions = Job.osc_versions(self.type).collect {|x| x[0]}
      if versions.include?(self.version)
        mod = "module purge && module load 'beast/#{self.version}'"
      else
        mod = "module purge && module load 'beast/#{versions[0]}'"
      end
      runme = "qsub -V #{remote_dir}/#{self.id}/#{self.id}.sh"
      output = `ssh oboe@#{$osc_host}.#{$osc_domain} \"#{mod} && #{runme}\"`
      output.chomp!
      if output =~ /^\d+\.#{$osc_host}/
        # looks like it worked
        Rails.logger.info("VARS #{self.id}")
        self.vars[:oscid] = output
        self.status = "in progress"
        self.save
        CheckingWorker.perform_at(60.minutes.from_now, self.id)
        Rails.logger.info("Completed submission for BEAST job #{self.id}")
      else
        jobfail("BEAST fail: #{output}: ","BEAST submission failed")
        return
      end

    end

    def check_progress_beast
      self.check_osc_job
    end
  end
end
