class JobsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show,:download,:download_coords]
  layout :resolve_layout

  # Note - users should only see their own jobs. Jobs are not an embedded 
  # document type within users as they must be treated separately by the
  # processing system. Therefore, every time a job is found by id its
  # ownership must be checked against the current logged-in user and 
  # naughty users who have posted an id they shouldn't should be 
  # re-directed to their own list of jobs.

   
  # GET /jobs
  # GET /jobs.xml
  def index
    # it has been requested that users only see LEFT (and LEFT-type) jobs on the LEFT pages, and
    # so on. This should do it, if different types are added in the array at the end of the search
    # string.
    @apologies = ""
    @jobs = Job.paginate :page => params[:page], :order => 'created_at DESC', :email => current_user.email

    # user account
    # this is to only show users jobs they can currently run. Of course, they
    # may get around this here but they should be stopped by this same check being performed
    # on job creation
    account = Account.find(current_user.account) 

    @selectopts = {}
    Job.types.each_pair do |k,v|
      if ((Time.now - (60*60*24) <= Date.strptime(account.expiry[v], "%d/%M/%Y")) and (account.arrears[v] == 'yes' or account.credits[v].to_i > 0))
        if Rails.env.production?
          @selectopts[k] = v if Job.active?(v)
        else
          @selectopts[k] = v
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
      format.json  { render :json => @jobs }
    end
  end

  def show
    @text = "<!-- show -->"
    begin
      @job = Job.find(params[:id])
      @type = Job.types.invert[@job.type]
    rescue 
      flash[:alert] = "Job #{params[:id]} not found"
      redirect_to :jobs and return
    end

    @error = @job.errormsg
    if !@job.proper_infilename.nil?
      @infile = @job.proper_infilename
    else
      @infile = @job.infile_name
    end

    @headers = @job.type

    # if the job is not yet ready then the page should refresh, the
    # interval to depend upon the job type
    if @job.status == 'finished'
      @js = ""
    else
      timeout = Job.timeout?(@job.type);
      @js = <<EOF;
<script>
$(document).ready(function() {
  setTimeout(function() {
    check_status();
  }, #{timeout > 10000 ? 10000 : timeout}); // first run should at <= 10s
});

function check_status() {
  $.get('/jobs/status/#{@job.id}', function(data) {
    $('.job_status').html(data);
    if (data == 'finished') 
    {
      alert('Job finished!');
      location.reload();
    }
    else
    {
      setTimeout(function() {
        check_status();
      }, #{timeout});
    }
  });
}
</script>
EOF
    end

    # anyone may see public jobs, but if the job is private then
    # only the logged in user may see it
    if @job.public
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @job }
        format.json  { render :json => @job }
      end
    else
      if !current_user
        authenticate_user!
      elsif !check_user(@job)
        flash[:alert] =  'Job not available'
        redirect_to :jobs and return
      else
        respond_to do |format|
          format.html #{ render :layout => layout } # show.html.erb
          format.xml  { render :xml => @job }
          format.json  { render :json => @job }
        end
      end
    end

  end

  def get_status
    begin
      @job = Job.find(params[:id])
    rescue 
      render :text => ""
    end
    render :text => @job.status
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    if !params[:type].nil?
      session[:type] = params[:type]
      @type = Job.types.invert[params[:type]]
      @headers = params[:type]
    else
      @type = Job.types.invert[session[:type]]
      @headers = session[:type]
    end

    # give up here if the user has not specified the correct sort of job
    unless Job.types.collect {|x| x[0]}.include?(@type)
      flash[:alert] = "Job creation failed!"
      redirect_to "/home" and return
    end

    # finally, render the job form
    @job = Job.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @job }
      format.json  { render :json => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @text = "<!-- no comment -->"
    @job = Job.find(params[:id])

    @title = "Editing analysis"
    # Fri Nov 18 16:31:20 GMT 2011
    # This section kept failing because I had set the application to read from slaves;
    # the slaves could not sync fast enough and so a new job hadn't got to them by the
    # time the Job.find request below was run. Solution: Read only from master
    begin
      Rails.logger.error("Editing ID: #{params[:id]}")
      if !check_user(@job) 
        flash[:alert] =  'Invalid job ID'
        redirect_to :jobs and return
      end
      Rails.logger.info("Found job: #{@job}")

      session[:type] = @job.type
      @headers = @job.type
      @type = Job.types.invert[@job.type]
    rescue
      flash[:alert] = "Can't edit job #{params[:id]}"
      redirect_to :jobs  and return
    end

    if !check_user(@job) 
      flash[:alert] = 'Invalid job ID'
      redirect_to :jobs and return
    end

  end

  # POST /jobs
  # POST /jobs.xml
  def create
    # job type affects who can create jobs
    if !session[:type].nil?
      type = session[:type]
    else
      type = params[:job][:type]
    end

    
    # here, the user must be found and their account determined. Then, before going any
    # further, expiry then credits can be checked. Re-direct to job listing with appropriate
    # flash, or give a plain text error message otherwise
    account = Account.first(:users => current_user.id)
    # expiry
    if Time.now - (60 * 60 * 24) > Date.strptime(account.expiry[type], "%d/%M/%Y")
      flash[:alert] = "Your account has expired. Please contact the administrator to re-instate it"
      redirect_to :jobs and return
    end
    if account.credits[type].to_i <= 0 and account.arrears[type] == 'no'
      flash[:alert] = "Your account has no credit left. Please contact the administrator to obtain more"
      redirect_to :jobs and return
    end

    # create the job here
    # no bulk assignment unless user tries to set 'vars', which should contain stuff which only
    # comes from a 'safe' source, e.g. one of our private webservices
    #@job = Job.new(params[:job])
    @job = Job.new
    @job.job_name = params[:job][:job_name]
    @job.job_description = params[:job][:job_description]
    @job.parameters = params[:job][:parameters]
    @job.infile = params[:job][:infile] if !params[:job][:infile].nil?
    @job.inputurl = params[:job][:inputurl] if !params[:job][:inputurl].nil?
    if params[:job][:public] == 1 or params[:job][:public] == "1"
      @job.public = true
    else
      @job.public = false
    end

    # note: some types of job don't pass their parameters as for bulk assignment, so they
    # must be dealt with separately here
    Rails.logger.info("TYPE: #{type}")
    vfile = "#{Vibrant::Application.config.dropbox}/#{type}/version.txt"
    if !params[:job][:version].nil?
      version = params[:job][:version]
    elsif File.exists?(vfile)
      version = IO.readlines(vfile)[0].chomp!
    else
      version = "N/A"
    end
    Rails.logger.error("VERSION: #{version}")
   

    # assign everything else
    @job.type = type
    @job.version = version
    @job.email = current_user.email
    @headers = @job.type

    
    respond_to do |format|
      if @job.save 
        if StartingWorker.perform_async(@job.id)
          flash[:notice] = 'Job was successfully created.'
          Rails.logger.info("StartingWorker success for job: #{@job.id}")
        else
          flash[:notice] = 'Job failed to run.'
          Rails.logger.info("StartingWorker FAIL for job: #{@job.id}")
        end
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
        format.json  { render :json => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
        format.json  { render :json => @job.errors.full_messages, :status => :unprocessable_entity } # an array of relevant errors will be reported
      end
    end
  end

  # users should be able to resubmit a job. But, this should be as a new job so that the
  # old output is preserved - this might be useful in cases where the job version has changed
  # and a comparison of old and new output is required
  def recreate

    @oldjob = Job.find(params[:id])
    @type = @oldjob.type
    @headers = @oldjob.type
    @title = "Re-submitting analysis"
    @text = "<p>You may edit this job before it is re-submitted.</p>"
    if !check_user(@oldjob) 
      flash[:alert] =  'Invalid job ID'
      redirect_to :jobs and return
    end
    
    # here, the user must be found and their account determined. Then, before going any
    # further, expiry then credits can be checked. Re-direct to job listing with appropriate
    # flash, or give a plain text error message otherwise
    account = Account.first(:users => current_user.id)
    # expiry
    if Time.now - (60 * 60 * 24) > Date.strptime(account.expiry[@type], "%d/%M/%Y")
      flash[:alert] = "Your account has expired. Please contact the administrator to re-instate it"
      redirect_to :jobs and return
    end
    if account.credits[@type].to_i <= 0 and account.arrears[@type] == 'no'
      flash[:alert] = "Your account has no credit left. Please contact the administrator to obtain more"
      redirect_to :jobs and return
    end


    # version &c.
    case @type
      when 'beast'
        version = @oldjob.version
      when 'left', 'sdm', 'lcc'
        version = IO.readlines("#{Vibrant::Application.config.dropbox}/#{@type}/version.txt")[0].chomp!
      else
        version = "N/A"
    end

    @job = Job.new
    @job.inputurl = @oldjob.inputurl
    @job.job_description = @oldjob.job_description 
    @job.job_name = @oldjob.job_name
    @job.version = version
    @job.email = @oldjob.email
    @job.type = @oldjob.type

    # these bits are done separately in case of any funny business
    # from the GridFS
    # N.B. from Mon Sep  5  2011 a code update somewhere caused this to start mucking about,
    # so I have written to a tempfile to get around the problems caused by trying to copy
    # a file within gridfs
    begin
      if !@oldjob.infile.nil?
        tempfile = Tempfile.open(@oldjob.infile_name)
        tempfile.write(@oldjob.infile.read.force_encoding('UTF-8')) 
        @job.infile = File.open(tempfile)
        tempfile.unlink
        if !@oldjob.proper_infilename.nil?
          @job.proper_infilename = @oldjob.proper_infilename
        else
          @job.proper_infilename = @oldjob.infile_name
        end
      end
    rescue
      Rails.logger.error("Infile copy failed when resubmitting job #{@oldjob.id}")
      flash[:alert] = 'Resubmission failed'
      redirect_to "/jobs/#{@oldjob.id}" and return
    end
    begin
      # a new parameter must be created here, and the old one iterated over
      if !@oldjob.parameters.nil?
        @job.parameters = @oldjob.parameters
      end
      if !@oldjob.vars[:oscid].nil?
        @job.vars[:oscid] = 'N/A' 
      end
      if !@oldjob.parameters[:identifier].nil?
        @job.parameters[:identifier] = 'N/A' 
      end
    rescue
      Rails.logger.error("Parameter copy failed when resubmitting job #{@oldjob.id}")
      flash[:alert] = 'Resubmission failed'
      redirect_to "/jobs/#{@oldjob.id}" and return
    end

    # the new job should now exist, so there should be no reason why it could not be saved
    # here...
    @job.status = 'held'
    if @job.save!
      flash[:notice] = 'Please check your job and submit'
      redirect_to :controller => 'jobs', :action => 'edit', :id => @job.id and return
    else
      Rails.logger.error("Save failed for resubmission of job #{@oldjob.id}")
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])
    @text = "<!-- update -->"

    if !check_user(@job) 
      flash[:alert] =  'Invalid job ID'
      redirect_to :jobs and return
    else
      respond_to do |format|
        if @job.update_attributes(params[:job]) 
          if @job.status = "held"
            @job.update_attributes(:status => 'new')
            StartingWorker.perform_async(@job.id)
          end
          flash[:notice] = 'Job was successfully updated.'
          format.html { redirect_to(@job) }
          format.xml  { head :ok }
          format.json  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
          format.json  { render :json => @job.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    if !check_user(@job) 
      flash[:alert] = 'Job not available'
      redirect_to :jobs and return
    end

    # if this is a drop and compute job being killed off before it is finished
    # then the remotely running task needs to be killed off
    if (@job.status == 'in progress' and Job.maptypes.include?(@job.type))
      FileUtils.touch "#{Vibrant::Application.config.dropbox}/#{@job.type}/#{@job.id}.stop"
    end

    # now kill it
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

  # search
  def search
    begin
      conditions = {}
      conditions[:email] =  current_user.email
      conditions[:status] = params[:status]  if params[:status].present?
      conditions[:type] = params[:type]  if params[:type].present?
      conditions[:user_id] = params[:user_id]  if params[:user_id].present?
      @jobs = Job.all( conditions)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @jobs }
        format.json  { render :json => @jobs }
      end
    rescue
      render :text => 'No results found.'
    end
  end

  # send a file from gridfs back to the user
  # in this case the original input file
  def get_infile
    begin
      @job = Job.find(params[:id])
      @outfile = @job.infile # i.e. spit out the original input...
      # provide a user-friendly filename for
      # this download, if it's been downloaded
      # with URI and has a gibberish one
      if !@job.proper_infilename.nil?
        output_filename = @job.proper_infilename
      else
        output_filename = @outfile.filename
      end
      # no looking at other people's jobs!
      if !check_user(@job)
        flash[:alert] =  'Invalid job ID'
        redirect_to :jobs
      else 
        # stream as attachment
        # send the data directly to the browser as an attachment
        send_data @outfile.read, :filename => output_filename, :disposition => 'attachment', :type => @outfile.type
      end
    rescue
      flash[:alert] =  "Error downloading input for job #{@job.id}"
      redirect_to :jobs
    end
  end
  
  # this is not really infile streaming any more, but should allow users to download
  # their co-ordinates in a useful manner
  def download_coords
    @job = Job.find(params[:id])
    continue = 0
    if @job.public
      continue = 1
    elsif !current_user
      authenticate_user!
    elsif !check_user(@job)
      flash[:alert] =  'Job not available'
      redirect_to :jobs and return
    else
      continue = 1
    end
    # download here
    if continue == 1 
      output = "# coordinates for job #{@job.id}, prepared at #{Time.now}\n"
      output += @job.parameters[:coords]
      send_data output, :filename => "#{@job.id}.txt", :disposition => 'attachment', :type => 'text/plain'
    else
      flash[:alert] =  'Job not available, sorry'
      redirect_to :jobs and return
    end
  end

  # and now the actual finished data
  def download
    if current_user
      Rails.logger.info("DOWNLOAD at #{Time.now}: #{current_user.email}")
    else
      Rails.logger.info("DOWNLOAD at #{Time.now}: anonymous at #{request.ip}")
    end
    begin
      @job = Job.find(params[:id])
      @outfile = @job.outfile
      if @job.proper_outfilename.nil? and !@job.outfile.blank?
        outname = @outfile.filename
      else
        outname = @job.proper_outfilename
      end

      # a continue parameter to determine whether to download
      continue = 0
      if @job.public
        continue = 1
      elsif !current_user
        authenticate_user!
      elsif !check_user(@job)
        flash[:alert] =  'Job not available'
        redirect_to :jobs and return
      else
        continue = 1
      end

      # now actually download the job
      if continue == 1 
        # stream as attachment
        # send the data directly to the browser as an attachment
        if @job.type == 'durden'
          send_data(File.read("/storage/durden/#{@job.id}.zip"), :filename => "#{@job.id}.zip", :disposition => 'attachment', :type => "application/zip")
        elsif @job.type == 'ggws'
          send_data @job.vars['output'], :filename => "#{@job.id}.#{@job.parameters['outputFormat'].downcase}", :disposition => 'inline', :type => "text/#{@job.parameters['outputFormat'].downcase}"
        elsif @job.type == 'zooquery'
          send_file("/storage/oboe/Jobs/zooquery/#{@job.id}.zip", :filename => "#{@job.id}.zip", :disposition => 'attachment', :type => "application/zip")
        else
          send_data @outfile.read, :filename => outname, :disposition => 'attachment', :type => @outfile.type
        end

        # logging should take place here so that the download won't be logged if the send_data call
        # above fails
        logfile = "#{Vibrant::Application.config.dropbox}/oboe_downloads_#{Rails.env}.txt"
        begin
          open(logfile, 'a') do |f|
            if current_user
              f.puts "#{@job.id},#{current_user.email},#{request.ip},#{Time.now}"
            else
              f.puts "#{@job.id},anonymous,#{request.ip},#{Time.now}"
            end
          end
        rescue
          Rails.logger.error("Could not write to logfile!")
        end
        if current_user
          @job.downloads << "#{current_user.email},#{request.ip},#{Time.now}"
        else
          @job.downloads << "anonymous,#{request.ip},#{Time.now}"
        end
        @job.save

      else
        # this shouldn't be called
        flash[:alert] =  'Job not available, sorry'
        redirect_to :jobs and return
      end
    rescue
      flash[:alert] =  "Error downloading job #{params[:id]}"
      redirect_to :controller => '/jobs', :action => 'show', :id => @job.id
    end
  end

  # a means for admins to see all jobs on the system
  def show_all
    if !current_user.admin?
      redirect_to :jobs and return
    end
    # allow admins to filter jobs by type
    @types = Hash['All' => 'all'].merge(Job.types)
    @currtype = params[:type]
    if params[:type] == 'all' or params[:type].blank?
      @jobs = Job.paginate :page => params[:page], :order => 'created_at DESC'
    else
      @jobs = Job.paginate :page => params[:page], :order => 'created_at DESC', :conditions => {:type => params[:type]}
    end
    
    # this fails on the production server for unknown reasons
    # and is temporarily disabled until the problem is fixed
    #@jobs.sort! {|a,b| a.email <=> b.email }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
      format.json  { render :json => @jobs }
    end

  end
  

  # listing of public jobs
  def show_all_public
    # equivalent to show_all
  end

  # allow turning on and off of public jobs
  def toggle_public
    @job = Job.find(params[:id])
    if !check_user(@job)
      flash[:alert] =  'Job not available'
      redirect_to :controller => '/jobs', :action => 'show', :id => @job.id and return
    else 
      @job.public = !@job.public
      if @job.save
        Rails.logger.error("SAVE succeeded")
        flash[:notice] = "Job #{@job.id} public status changed"
        redirect_to :controller => '/jobs', :action => 'show', :id => @job.id
      else
        Rails.logger.error("SAVE failed")
        flash[:alert] = "Job #{@job.id} public status not changed"
        redirect_to :controller => '/jobs', :action => 'show', :id => @job.id
      end
    end
  end
  

  # unzip a job to /storage/left if not already there, and stream it to the
  # user if it does already exist...
  def leftstream
    jobid = params[:id]
    @job = Job.find(jobid)
    if !check_user(@job) or @job.status != 'finished' 
      render :status=>401, :json=>{:message=>"Forbidden"}
      return
    end
    leftdir = "/storage/left"
    if !File.exists?("#{leftdir}/#{jobid}.pdf")
      Rails.logger.info("Creating directory for #{jobid}")
      begin
        File.open("#{leftdir}/#{jobid}.zip","w") {|f| f.write(@job.outfile.read.force_encoding('UTF-8')) }
        system("cd #{leftdir} && unzip #{jobid}.zip && rm #{jobid}.zip")
        if File.exists?("#{leftdir}/#{jobid}/output/output_mobile.pdf")
          system("mv #{leftdir}/#{jobid}/output/output_mobile.pdf #{leftdir}/#{jobid}.pdf")
        else
          system("mv #{leftdir}/#{jobid}/output/output.pdf #{leftdir}/#{jobid}.pdf")
        end
        system("rm -rf #{leftdir}/#{jobid}")
      rescue
        render :status=>500, :json=>{:message=>"File retrieval failed"}
        return
      end
    else
      Rails.logger.info("Output for #{jobid} already exists")
    end
    # stream the pdf
    send_file "#{leftdir}/#{jobid}.pdf", :content_type => "application/pdf", :filename => "#{jobid}.pdf"
  end

  

end
