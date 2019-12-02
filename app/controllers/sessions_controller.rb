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
    if user && user.authenticate(params[:session][:password])
      # ログイン成功
      log_in(user)
      redirect_to user
    else
      # describe message and redirect to login form.
      flash[:danger] = 'emailまたはpasswordが間違っています。'
      redirect_to login_path
    end
  end

  # logout operation
  def destroy

  end

end
