module ApplicationHelper

  # PageLocation----------------------------------------------------------
  # function
  #   ・ before page url setting
  # used
  #   ・follow and unfollow
  def set_just_before_location
    session[:just_before_url] = request.referer
  end
  
  # function
  #   ・ before page url setting
  # used
  #   ・follow and unfollow
  def get_just_before_location(url=root_path)
    url = session[:just_before_url] || url
    session.delete(:just_before_url)
    url
  end


end
