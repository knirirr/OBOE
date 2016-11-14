class UserMailer < ActionMailer::Base
  default :from => 'noreply.oboe@oerc.ox.ac.uk'
  $admin = 'neil.caithness@oerc.ox.ac.uk'
  $sysadmin = 'milo.thurston@oerc.ox.ac.uk'

  def job_ready(user,job)
    @user = user
    @job = job
    @url = job.outputurl
    @title = job.job_name
    @description = job.job_description
    @blurb = job.blurb_win
    @type = Job.types.invert[job.type]
    return if @user.notify == false
    mail(:to => user.email,
         #:from => job.email_from,
         :subject => "Your #{@type} analysis has completed")

  end

  def job_failed(user,job)
    @user = user
    @job = job
    @title = job.job_name
    @description = job.job_description
    @blurb = job.blurb_fail
    @type = job.type
    return if @user.notify == false
    mail(:to => user.email,
         :subject => "Your #{@type} analysis has failed")


  end

  def admin_job_failed(job)
    @job = job
    @title = job.job_name
    @description = job.job_description
    @id = job.id
    @error = job.errormsg
    @type = Job.types.invert[job.type]
    mail(:to => "#{$admin},#{$sysadmin}",
         :subject => "A #{@type} analysis has failed")


  end


  def send_left_logs(job)
    @job = job
    if Rails.env.production?
      @body = IO.readlines("/home/vibrant/left/output/#{job.id}/logfile.txt")
    else
      @body = IO.readlines("/storage/left/output/#{job.id}/logfile.txt")
    end
    mail(:to => $admin,
         #:from => 'noreply.left@oerc.ox.ac.uk',
         :subject => "LEFT analysis logfile (#{@job.status}): #{@job.id}")


  end

  def new_user(user)
    @user = user
    mail(:to => $admin,
         #:from => @user.email,
         :subject => "New user created: #{@user.email}")
  end

  def left_running(job)
    @job = job
    if Rails.env.production?
      @url = "https://oboe.oerc.ox.ac.uk/inspect/left/#{job.id}"
    else
      @url = "http://bonnacon.oerc.ox.ac.uk:3000/inspect/left/#{job.id}"
    end
    mail(:to => $admin,
         #:from => 'noreply.left@oerc.ox.ac.uk',
         :subject => "LEFT analysis started: #{@job.id}")

  end

end


