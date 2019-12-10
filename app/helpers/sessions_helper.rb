module SessionsHelper

  # function
  #   ・login by argument user
  # used
  #   ・save login user info by session.
  #   ・prepare for test.
  def log_in(user)
    session[:login_user_id] = user.id
    set_user_info_in_cookie(user)
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
    if (user_id = session[:login_user_id])
      @current_user ||= User.find_by(id: session[:login_user_id])
    elsif (user_id = cookies.signed[:login_user_id]) 
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
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
    delete_user_info_in_cookie(current_user)
    session.delete(:login_user_id)
    @current_user = nil
  end

  # function
  #   ・login check
  # used
  #   ・prevent to manipulate invalid operration
  def check_logged_in
    if !logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_path
    end
  end

  # function
  #   ・login check
  # used
  #   ・prevent to manipulate invalid operration
  def check_correct_user
    user = User.find_by(id: params[:id])
    if !(current_user?(user))
      flash[:danger] = "ユーザーが違います。"
      redirect_to root_path
    end
  end

  # function
  #   ・login setting
  # used
  #   ・prevent to manipulate invalid operration
  def set_user_info_in_cookie(user)
    user.remember_in_db
    cookies.permanent.signed[:login_user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  # function
  #   ・ logout setting
  # used
  #   ・prevent to manipulate invalid operration
  def delete_user_info_in_cookie(user)
    user.forget_in_db
    cookies.delete(:login_user_id)
    cookies.delete(:remember_token)
  end

end
