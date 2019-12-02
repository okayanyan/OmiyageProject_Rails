module SessionsHelper

  # function
  #   ・login by argument user
  # used
  #   ・save login user info by session.
  #   ・prepare for test.
  def log_in(user)
    session[:login_user_id] = user.id
  end

  # function
  #   ・get login user
  # used
  #   ・change templates if logged in or not.
  #      ・For example, button to delete posts.
  def current_user
    if session[:login_user_id]
      @current_user ||= User.find_by(id: session[:login_user_id])
    end
  end

  # function
  #   judge login or not
  # used
  #   ・change templates if logged in or not.
  #      ・For example, login link.
  def logged_in?
    !current_user.nil?
  end

  # function
  #   ・logout
  # used
  #   ・delete login user info by session.
  #def log_out
  #  session.delete(:login_user_id)
  #  @current_user = nil
  #end
end
