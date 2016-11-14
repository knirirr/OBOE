class InfoController < ApplicationController
  before_filter :authenticate_user!, :except => [:welcome,:welcome_left,:privacy,:information,:faq]
  layout :resolve_layout
  before_filter :admin_only, :only => [:inspect]

  # some stuff for osc machines
  $osc_host = "sal"
  $osc_domain = "oerc.ox.ac.uk"
  $admin_email = "oboe-services@oerc.ox.ac.uk"


  # text-only welcome page
  def welcome
    @ip = request.remote_ip
    #session[:style] = 'oboe'
    # hack to force reload when back button is pressed
    # http://stackoverflow.com/questions/711418/how-to-prevent-browser-page-caching-in-rails
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"

    newsfile = "#{Vibrant::Application.config.dropbox}/news.txt"
    if File.exists?(newsfile)
      @news = IO.read(newsfile)
    else
      @news = ""
    end
  end

  # for users being directed straight to the "left" job creation 
  # page via $root_url/left
  def welcome_left
    #session[:style] = 'left'
  end

  # some EU cookie stuff
  def privacy
  end

  def faq
  end

  # display routing
  def routes
    Rails.application.reload_routes!
    all_routes = Rails.application.routes.routes
    require 'rails/application/route_inspector'
    inspector = Rails::Application::RouteInspector.new
    @routes = inspector.format(all_routes, ENV['CONTROLLER']).collect {|x|
      if x !~ /accounts|user|sidekiq|tokens/ 
        "#{x}\n"
      else
        nil
      end
    }.join("")
  end

  # this needs to be fixed so that it knows where to look without 
  # this naughty hard-coding
  def docs
    @info = String.new
    IO.readlines("#{Rails.root}/doc/instructions").each do |line|
      @info << line
    end
  end

  # return a list of parameters for each type of job
  def parameters
    output = Job.paramtypes(params[:type])
    render :json => output
  end

  def job_types
    if Rails.env.production? 
      input = Job.types.invert
      output = {}
      input.each_pair do |k,v|
        output[k] = v if Job.active?(k)
      end
    else
      output = Job.types.invert     
    end
    render :json => output
  end

  # provide a brief summary of what a job does so that the users can have
  # some idea what they're getting into
  def information
    #render :json => { 'oboe' => Job.information }
    render :json => Job.information
  end

  # look at the logs coming from a left job
  def inspect
    @id = params[:id]
    @type = params[:type]
    case @type
    when 'left','lcc','bict','cde'
      file = "#{Vibrant::Application.config.dropbox}/#{@type}/logs/#{@id}.txt"
      if File.exists?(file)
        @output = IO.readlines(file);
      else
        @output = ["No log found"]
      end
    when 'beast','mrbayes'
      @job = Job.find(@id)
      parts = @job.vars[:oscid].split(/\./)
      oscid = parts[0] + "." + parts[1]
      begin
        @output = ["#{$osc_host}:\n","                                                                               Req'd    Req'd      Elap\n","Job ID               Username    Queue    Jobname          SessID NDS   TSK    Memory   Time   S   Time\n","-------------------- ----------- -------- ---------------- ------ ----- ------ ------ -------- - --------\n"]
        @output << `ssh oboe@#{$osc_host}.#{$osc_domain} qstat -u oboe | grep #{oscid}`
        @output << "\n"
        #@output << `ssh oboe@#{$osc_host}.#{$osc_domain} qstat -f #{@job.vars[:oscid].gsub(/$osc_host/,"")} | grep comment`
      rescue
        @output = ["No output available."]
      end
    else
      @output = ["Not yet implemented, sorry."]
    end
    render :layout => 'logrender'
  end
  
  #private 
end
