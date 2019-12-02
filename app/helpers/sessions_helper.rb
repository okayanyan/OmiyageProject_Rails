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
  #   judge login or not
  # used
  #   ・change templates if logged in or not.
  #      ・For example, login link.
  def logged_in?
    !current_user.nil?
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

  def current_user?(user)
    user == current_user
  end

  # function
  #   ・logout
  # used
  #   ・delete login user info by session.
  def log_out
    session.delete(:login_user_id)
    @current_user = nil
  end

  # function
  #   ・login check
  # used
  #   ・prevent to manipulate invalid operration
  def check_logged_in
    redirect_to root_path unless logged_in?
  end

  # function
  #   ・login check
  # used
  #   ・prevent to manipulate invalid operration
  def check_correct_user
    user = User.find_by(params[:login_user_id])
    redirect_to root_url unless current_user?(user)
  end

end
