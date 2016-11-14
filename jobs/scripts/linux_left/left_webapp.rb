require 'rubygems'

# actually, this isn't going to deal with left only,
# but with other, similar jobs

# If you're using bundler, you will need to add this
require 'bundler/setup'
require 'sinatra'

$outdir = "/home/vibrant/left/output"

after do
  response.status
end

get '/' do
  "Nothing to see here, move along."
end

# check a job version
put '/version/:job' do
  job = params[:job]  
  case job
  when 'test'
    1.0
  when 'left'
    IO.readlines("/home/vibrant/left/bin/version.txt")[0].chomp!
  else
    0.0
  end
end

# this is no longer a custom template upload, instead it uploads
# a species data zip file. The file must be unzipped by the processing
# script when run from cron
put '/custom/:id/:file' do
  file = params[:file]
  id = params[:id]
  unless File.exists?("#{$outdir}/#{id}/data/gbif")
    FileUtils.mkdir_p "#{$outdir}/#{id}/data/gbif"
  end
  File.open("#{$outdir}/#{id}/data/gbif/#{file}", 'w+') do |file|
    file.write(request.body.read)
    nothing = `cd #{outdir}/#{id}/data/gbif/ && unzip -j #{file}`
    File.unlink("#{outdir}/#{id}/data/gbif/#{file}")
  end
end

# upload the args.txt file
put '/args/:id/:file' do
  file = params[:file]
  id = params[:id]
  unless File.exists?("#{$outdir}/#{id}")
    FileUtils.mkdir "#{$outdir}/#{id}"
  end
  File.open("#{$outdir}/#{id}/#{file}", 'w+') do |file|
    file.write(request.body.read)
  end
  system "echo #{id} >> #{$outdir}/process.txt"
end


put '/check/:id' do 
  id = params[:id]
  file = "#{$outdir}/#{id}.zip"
  outputfile = "#{$outdir}/#{id}/output.html"
  finished = "#{$outdir}/#{id}.finished"
  if !File.exists?(outputfile) && File.exists?(finished)
    "Failed"
  elsif File.exists?(file)
    "Ready"
  else
    "Not ready"
  end
end

get '/zip/:id' do 
  id = params[:id]
  file = "#{$outdir}/#{id}.zip"
  send_file(file, :disposition => 'attachment', :filename => File.basename(file))
  #File.unlink(file)
end


get '/*' do
  "Truly, there is nothing to see here. Move along."
end

