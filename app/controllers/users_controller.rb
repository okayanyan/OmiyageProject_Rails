class UsersController < ApplicationController

  # function
  #   ・describe user page
  # used
  #   ・want to describe user page
  #     ・redirect when logged in.
  #       etc...
  def show
    @user = User.find_by(params[:id])
  end

  # function
  #   ・describe sign up form
  # used
  #   ・want to describe sign up form
  def new
    @user = User.new
    if has_create_user_info?
      get_create_user_info
    end
  end

  # function
  #   ・sign up operation
  # used
  #   ・create user
  def create
    @user = User.new(user_params)
    if @user.save
      # success
      flash[:success] = "ユーザーが作成されました。"
      #   save in session 
      log_in @user
      redirect_to @user
    else
      set_create_user_info
      set_error_info(@user)
      redirect_to new_user_path
    end
  end

  private
    # function
    #   ・function to limit post parameter 
    # used
    #   ・prevent malicious request
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # function
    #   ・function to save input parameter
    # used
    #   ・redirect sign up form when failed to validate
    def set_create_user_info
      if @user.name
        session[:user_name] = @user.name
      end
      if @user.email
        session[:user_email] = @user.email
      end
    end
    
    # function
    #   ・function to get input parameter
    # used
    #   ・redirect sign up form when failed to validate
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

    # function
    #   ・function to judge input parameter
    # used
    #   ・redirect sign up form when failed to validate
    def has_create_user_info?
      !(session[:user_name].nil? && session[:user_email].nil?)
    end

end
