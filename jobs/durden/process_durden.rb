#!/usr/bin/env ruby

require 'fileutils'

# purpose: to flip out and run via cron, processing the files in uploads.txt
# so that the sinatra application can return the zip file to the users

# first, provide the necessary output dirs and
# location of list of files to be processed
outdir = "/home/vibrant/durden"
process = "#{outdir}/process.txt"

# no need to run if there's no data
if File.exists?(process)
  durdenjobs = IO.readlines(process).uniq
  File.unlink(process)
else
  #puts "Nothing to do; exiting."
  exit
end

durdenjobs.each do |job|
  durden = "/home/vibrant/bin/durden"
  puts "Started: #{Time.now}"
  puts "Processing: #{job}"
  infile,jobid,tile_size = job.chomp.split(/\s+/)
  # execute the left code
  command = system("cd #{outdir} && wget #{infile} && #{durden} #{File.basename(infile)} #{outdir}/#{jobid} #{tile_size} && zip -r #{jobid}.zip #{jobid} && touch #{jobid}.finished && rm #{File.basename(infile)}")
  puts command
  if $?.exitstatus != 0
    system("touch #{outdir}/#{id}.fail")
  end
  puts "Finished: #{Time.now}"


end

# clean up
deletes = Dir["#{outdir}/*delete"]
deletes.each do |d|
  id = d.split(/\//)[-1].gsub(/\.delete$/,"")
  begin
    FileUtils.rm_rf("#{outdir}/#{id}")
    File.unlink("#{outdir}/#{id}.finished")
    File.unlink("#{outdir}/#{id}.delete")
  rescue
    puts "Delete failed for #{id}"
  end
end
