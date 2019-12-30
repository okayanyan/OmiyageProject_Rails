class SessionsController < ApplicationController

  # function
  #   ・describe login form
  # used
  #   ・login
  def new
  end

  # function
  #   ・login operation
  # used
  #   ・login
  def create
    # get user information
    user = User.find_by(email: params[:session][:email].downcase)
    # check existance of user and password authentication.
    if user && user.activated? && user.authenticate(params[:session][:password])
      flash[:success] = "ログインに成功しました。"
      # save session
      log_in(user)
      redirect_to user
    else
      flash[:danger] = 'emailまたはpasswordが間違っています。'
      redirect_to login_path
    end
  end

  # function
  #   ・logout operation
  # used
  #   ・logout
  def destroy
    if logged_in?
      flash[:success] = "ログアウトしました。"
      log_out
    end
    redirect_to root_path
  end

end
