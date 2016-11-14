module AccountsHelper

  def expired?(date)
    if Time.now - (60 * 60 * 24) > Date.strptime(date, "%d/%M/%Y")
      return "#{date} - Expired"
    else
      return date
    end
  end

  def arrearcolour(flag)
    if flag == 'yes'
      return "#33CC33"
    else
      return "#FF3300"
    end
  end

  def arreartext(flag)
    if flag == 'yes'
      return "Yes"
    else
      return "No"
    end
  end

  def abuttong(flag)
    if flag == 'yes'
      return "btn btn-success"
    else
      return "btn btn-danger"
    end
  end

end

