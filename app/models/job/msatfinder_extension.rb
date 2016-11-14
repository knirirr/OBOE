class Job
  module MsatfinderExtension
    def process_new_msatfinder
      Rails.logger.info("I'm about to process msatfinder job #{self.id}")

      # the coordinates may be stored as a proper coordinate string or by 
      # four simple values supplied by simple users. Here one converts
      # the latter into the former
      user = User.find_by_email(self.email)

      # the engine would normally be a command line flag, as would the infile,
      # but I've put both in the config file so I don't have to use flags
      engine = 1
      case self.parameters['engine']
      when 'multipass'
        engine = 2
      when 'iterative'
        engine = 3
      end

      # create the msatfinder.rc file
      # now I wish I'd designed "motif_threshold" to work differently all those years ago...
      rcfile = <<EOF
[COMMON]
debug = 0
flank_size = #{self.parameters['flank_size']}
mine_dir = "MINE/"
repeat_dir = "Repeats/"
tab_dir = "Msat_tabs/"
bigtab_dir = "Flank_tabs/"
fasta_dir = "Fasta/"
prime_dir = "Primers/"
align_dir = "Aligner/"
count_dir = "Counts/"

[DEPENDENCIES]
run_eprimer = 1
eprimer_args = "-primer -productsizerange #{self.parameters['min_prod']}-#{self.parameters['max_prod']}"
eprimer = "/usr/bin/eprimer3"
primer3core = "/usr/bin/primer3_core"

[FINDER]
override = 0
motif_threshold = "1,#{self.parameters['r_1_th']}|2,#{self.parameters['r_2_th']}|3,#{self.parameters['r_3_th']}|4,#{self.parameters['r_4_th']}|5,#{self.parameters['r_5_th']}|6,#{self.parameters['r_6_th']}"
artemis = 1
mine = 1
fastafile = 1
phages = "viruses"
viroids = "viruses"
plant_viruses = "viruses"
megaplasmids = "plasmids"
remote_link="http://www.ncbi.nlm.nih.gov/entrez/viewer.fcgi?val="
sumswitch = 1
screendump = 0

[INFILE]
infile = "#{self.inname}"

[ENGINE]
engine = "#{engine}"
EOF


      # first, it is necessary to create the directory structure
      tmpdir = "/tmp/#{self.id}"
      FileUtils.mkdir_p("#{tmpdir}")

      # write the input file to disk
      File.open("#{tmpdir}/#{self.inname}", 'w') {|f| f.write(self.infile.read.force_encoding('UTF-8')) }

      # create an rc file
      begin
        File.open("#{tmpdir}/msatfinder.rc","w") {|f| f.write(rcfile) }
      rescue
        self.jobfail("Could not write files for msatfinder job ","files not written")
        return
      end

      
      # then, move the msatfinder directory to the working directory
      dropdir = "#{Vibrant::Application.config.dropbox}/msatfinder"
      begin
        system("chmod -R 777 #{tmpdir}")
        FileUtils.mv "#{tmpdir}", "#{dropdir}"
        system("ssh vibrant@cockatrice touch #{dropdir}/#{self.id}")
      rescue
        self.jobfail("Could not prepare input for msatfinder job ","input file creation failure")
        return
      end

      # then:
      self.update_attributes(:status =>'in progress')
      CheckingWorker.perform_at(1.minutes.from_now, self.id)
      self.update_attributes(:vars => {:checked => 0})
    end

    def check_progress_msatfinder
      dropdir = "#{Vibrant::Application.config.dropbox}/msatfinder"
      if File.exists?("#{dropdir}/#{self.id}/fail.txt")
        self.jobfail("Server says no for ","server reports job failed")
        self.save
        File.unlink("#{dropdir}/#{self.id}")
        return
      elsif File.exists?("#{dropdir}/#{self.id}/done.txt")
        begin
          FileUtils.rm "#{dropdir}/#{self.id}/done.txt"
          out = `cd #{dropdir} && zip -r #{self.id}.zip #{self.id}`
          self.outfile = File.open("#{dropdir}/#{self.id}.zip")
          self.status = 'finished'
          self.save
          FileUtils.rm_rf "#{dropdir}/#{self.id}"
          # notify of success
          user = User.find_by_email(self.email)
          UserMailer.job_ready(user,self).deliver 
          File.unlink("#{dropdir}/#{self.id}.zip")
        rescue
          self.jobfail("Zip handling failed for ","could not process outfile")
          return
        end
      else 
        # still running
        case self.vars['checked']
        when 0..3
          self.checkup
          CheckingWorker.perform_at(2.minutes.from_now, self.id)
        when 4..6
          self.checkup
          CheckingWorker.perform_at(5.minutes.from_now, self.id)
        else
          CheckingWorker.perform_at(10.minutes.from_now, self.id)
        end
      end
    end

    def checkup
      self.update_attributes(:vars => {:checked => self.vars['checked'] + 1})
    end

  end
end
