class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
    if has_create_user_info?
      get_create_user_info
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      set_create_user_info
      set_error_info(@user)
      redirect_to new_user_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # function to save input info for error to sign up
    def set_create_user_info
      if @user.name
        session[:user_name] = @user.name
      end
      if @user.email
        session[:user_email] = @user.email
      end
    end
    
    # function to save input info for error to sign up
    def get_create_user_info
      if session[:user_name]
        @user.name = session[:user_name]
        session.delete(:user_name)
      end
      if session[:user_email]
        @user.email = session[:user_email]
        session.delete(:user_email)
      end
    end

    # function to save input info for error to sign up
    def has_create_user_info?
      !(session[:user_name].nil? && session[:user_email].nil?)
    end

end
