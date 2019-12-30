class UsersController < ApplicationController
  before_action :check_logged_in, only:[:edit, :update, :destroy]
  before_action -> {check_correct_user(User)}, only:[:edit, :update, :destroy]

  # function
  #   ・describe user page
  # used
  #   ・want to describe user page
  #     ・redirect when logged in.
  #       etc...
  def show
    @user = User.find_by(id: params[:id])
    @list = @user.post.all
    @list_type = "post"
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
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = "ユーザーの仮登録が完了しました。\nメールを確認して、登録を完了させてください。"
      #   save in session
      redirect_to root_path
    else
      set_create_user_info
      set_error_info(@user)
      redirect_to new_user_path
    end
  end

  # function
  #   ・describe user edit form
  # used
  #   ・update user information
  def edit
    @user = User.find_by(id: params[:id])
    if has_create_user_info?
      get_create_user_info
    end
  end

  # function
  #   ・update operation
  # used
  #   ・update user information
  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新が成功しました。"
      redirect_to @user
    else
      set_error_info(@user)
      redirect_to edit_user_path(@user)
    end
  end

  # function
  #   ・delete operation
  # used
  #   delete user information
  def destroy
    user = current_user
    if logged_in?
      log_out
    end
    user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to root_path
  end

  def following
    @user = User.find_by(id: params[:id])
    @list = @user.target_user
    @list_type = "follow"
    render :show
  end

  def followers
    @user = User.find_by(id: params[:id])
    @list = @user.following_user
    @list_type = "follow"
    render :show
  end

  private
    # function
    #   ・function to limit post parameter 
    # used
    #   ・prevent malicious request
    def user_params
      params.require(:user).permit(:name, :email, :image_key, :password, :password_confirmation)
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
