class Job
  module MrbayesExtension
    def process_new_mrbayes
      Rails.logger.info("I'm about to process mrbayes job #{self.id}")
      # first, we need to mount the remote directory in order that the necessary
      # outfiles can be written
      remote_dir = '/data/vibrant/oboe'
      local_dir = "#{Rails.root}/tmp/data"
      out_dir = "#{remote_dir}/#{self.id}"

      # batch file required to run Mr. Bayes
      # some proper values will be filled in here at some point
      # nst=6 rates=gamma
      batch = <<EOF
set autoclose=yes nowarn=yes
execute #{self.inname}
mcmc file=#{self.id}.nex
quit
EOF
      # prepare to write to file
      # N.B. -N must be truncated as PBS can't handle long names
      shortid = "oboe_#{self.id.to_s[14,10]}"
      output = <<EOF
#!/bin/bash
#PBS -V
#PBS -l walltime=100:00:00
#PBS -l nodes=1:ppn=8
#PBS -N #{shortid}
cd $PBS_O_WORKDIR
. enable_hal_mpi.sh
 
cd #{out_dir} && mpirun $MPI_HOSTS mb < #{out_dir}/batch.txt > #{out_dir}/log.txt 2> #{out_dir}/err.txt

EOF
      # open and write to file
      begin
        Dir.mkdir("#{local_dir}/#{self.id}")
        # PBS submit file
        File.open("#{local_dir}/#{self.id}/#{self.id}.sh", 'w') {|f| f.write(output) }
        # batch file
        File.open("#{local_dir}/#{self.id}/batch.txt", 'w') {|f| f.write(batch) }
        # Nexus file
        File.open("#{local_dir}/#{self.id}/#{self.inname}", 'w') {|f| f.write(self.infile.read.force_encoding('UTF-8')) }
        system("scp -r #{local_dir}/#{self.id} oboe@#{$osc_host}.#{$osc_domain}:#{remote_dir} ")
        FileUtils.rm_rf "#{local_dir}/#{self.id}"
      rescue
        self.jobfail("Could not create submission file for job ","submission file write failed")
        return
      end

      # version check in case of naughty code having be 
      versions = Job.osc_versions(self.type).collect {|x| x[0]}
      if versions.include?(self.version)
        mod = "module purge && module load 'mrbayes/#{self.version}'"
      else
        mod = "module purge && module load 'mrbayes/#{versions[0]}'"
      end
      runme = "qsub -V #{remote_dir}/#{self.id}/#{self.id}.sh"
      output = `ssh oboe@#{$osc_host}.#{$osc_domain} \"#{mod} && #{runme}\"`
      output.chomp!
      if output =~ /^\d+\.#{$osc_host}/
        # looks like it worked
        self.vars[:oscid] = output
        self.status = "in progress"
        self.save
        CheckingWorker.perform_at(60.minutes.from_now, self.id)
        Rails.logger.info("Completed submission for Mr. Bayes job #{self.id}")
      else
        jobfail("Mr. Bayes fail: #{output}: ","Mr. Bayes submission failed")
        return
      end
      

    end

    def check_progress_mrbayes
      self.check_osc_job
    end
  end
end
