module UserHelper

  def statcolour(flag)
    if flag.class == TrueClass
      return "#33CC33"
    else
      return "#FF3300"
    end
  end

  def stattext(flag)
    if flag.class == TrueClass
      return "Yes"
    else
      return "No"
    end
  end

  def buttong(flag)
    if flag.class == TrueClass
      return "btn btn-success"
    else
      return "btn btn-danger"
    end
  end

  def hostname(ip)
    if ip.nil?
      return "User has never logged in." 
    else
      addr = `host-woods #{ip}`
      if addr.nil?
        return "No information"
      else
        return addr.gsub(/\n/,"<br/>")
      end
    end
  end

end
