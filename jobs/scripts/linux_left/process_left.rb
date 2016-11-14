#!/usr/bin/env ruby

require 'pony'
require 'find'

# purpose: to flip out and run via cron, processing the files in uploads.txt
# so that the sinatra application can return the zip file to the users

# email configuration
Pony.options = { :from => 'noreply.left@gmail.com', :via => :smtp, :via_options => { :address => 'localhost' } }

# first, provide the necessary output dirs and
# location of list of files to be processed
leftdir = "/home/vibrant/left/bin"
outdir = "/home/vibrant/left/output"
process = "#{outdir}/process.txt"

# no need to run if there's no data
if File.exists?(process)
  leftjobs = IO.readlines(process).uniq
  File.unlink(process)
else
  puts "Nothing to do; exiting."
  exit
end

leftjobs.each do |job|
  job.chomp!

  # execute the left code
  command = "cd #{outdir}/#{job} && DISPLAY=:1 ./run_main.sh /opt/matlab/R2011a args.txt"
  nothing = `ln -sf #{leftdir}/run_main.sh #{outdir}/#{job}/run_main.sh`
  nothing = `ln -sf #{leftdir}/main #{outdir}/#{job}/main`
  matlabout = `#{command}`
  nothing = `rm #{outdir}/#{job}/run_main.sh`
  nothing = `rm #{outdir}/#{job}/main`

  # finally, try creating a pdf.
  # It doesn't really matter if this runs or not so there's no error checking here
  pdfout = `cd #{outdir}/#{job} && /usr/local/bin/wkhtmltopdf output.html output.pdf`

  # email the logs
  #loginfo = IO.readlines("#{outdir}/#{job}/logfile.txt")
  #Pony.mail(:to => 'neil.caithness@oerc.ox.ac.uk', :subject => "Left job #{job} logs", :body => loginfo)
   
  # at this point the job will have run but so an attempt to zip up the
  # job can be made
  if !File.exists?("#{outdir}/#{job}/output.html")
    # do something
  else
    nothing = `cd #{outdir} && /usr/bin/zip -r #{job}.zip #{job}`
    puts nothing
  end

end


      

