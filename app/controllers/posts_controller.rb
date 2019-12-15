class PostsController < ApplicationController
  before_action :check_logged_in, only:[:new, :create, :edit, :update, :destroy]
  before_action -> {check_correct_user(Post)}, only:[:edit, :update, :destroy]

  def index
    @post = filltering_post
    @prefecture = {' - ': nil}
    Prefecture.all.each {|p| @prefecture[p.name]=p.id}
  end

  def show
    @post = Post.joins(:user).joins(:prefecture).\
    select("posts.*, users.name as user_name, prefectures.name as prefecture_name").find_by(id: params[:id])
  end

  def new
    @post = Post.new
    @prefecture = Hash.new
    Prefecture.all.each {|p| @prefecture[p.name]=p.id}
    @evaluation = [1, 2, 3, 4, 5]
    if has_create_post_info?
      get_create_post_info
    end
  end

  def create
    user = current_user
    prefecture = Prefecture.find_by(id: prefecture_params)
    @post = user.post.new(post_params)
    @post.prefecture = prefecture
    if @post.save
      flash[:success] = '投稿に成功しました。'
      redirect_to @post
    else
      set_create_post_info
      set_error_info(@post)
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @prefecture = Hash.new()
    Prefecture.all.each {|p| @prefecture[p.name]=p.id}
    @evaluation = [1, 2, 3, 4, 5]
  end

  def update
    @post = Post.find_by(id: params[:id])
    if !(@post.prefecture.id == prefecture_params)
      prefecture = Prefecture.find_by(id: prefecture_params)
      @post.prefecture = prefecture
    end
    if @post.update_attributes(post_params)
      flash[:success] = '更新に成功しました。'
      redirect_to @post
    else
      set_error_info(@post)
      @post = Post.find_by(id: params[:id])
      redirect_to edit_post_path(id: @post.id)
    end


  end

  def destroy
    Post.find_by(id: params[:id]).destroy
    flash[:success] = "削除に成功しました。"
    redirect_to root_url
  end

  private
    def post_params
      params.require(:post).permit(\
        :title, :image_key, :evaluation, :content)
    end

    def prefecture_params
      params[:post][:prefecture]
    end

    # function
    #   ・function to save input parameter
    # used
    #   ・redirect sign up form when failed to validate
    def set_create_post_info
      if @post.title
        session[:post_title] = @post.title
      end
      if @post.prefecture
        session[:post_prefecture_id] = @post.prefecture.id
      end
      if @post.evaluation
        session[:post_evaluation] = @post.evaluation
      end
      if @post.content
        session[:post_content] = @post.content
      end
    end
    
    # function
    #   ・function to get input parameter
    # used
    #   ・redirect sign up form when failed to validate
    def get_create_post_info
      if session[:post_title]
        @post.title = session[:post_title]
        session.delete(:post_title)
      end
      if session[:post_prefecture]
        @post.prefecture = Prefecture.find_by(id: session[:post_prefecture_id])
        session.delete(:post_prefecture)
      end
      if session[:post_evaluation]
        @post.evaluation = session[:post_evaluation]
        session.delete(:post_evaluation)
      end
      if session[:post_content]
        @post.content = session[:post_content]
        session.delete(:post_content)
      end
    end

    # function
    #   ・function to judge input parameter
    # used
    #   ・redirect sign up form when failed to validate
    def has_create_post_info?
      !(session[:post_title].nil? && session[:post_prefecture].nil? && \
        session[:post_evaluation] && session[:post_content])
    end

    # function
    #   ・function to select post
    # used
    #   ・filltering queryset
    def filltering_post
      post = Post.all
      if !params[:word].nil? && params[:word].length > 0
        post = post.where("title LIKE ?", "%#{params[:word]}%")
      end
      if !params[:prefecture].nil? && params[:prefecture].to_i > 0
        post = post.where(prefecture_id: params[:prefecture])
      end
      if !params[:follow].nil? && params[:follow].to_i > 0
        post = post.where(user_id: current_user.target_user.ids)
      end
      post = post.paginate(page: params[:page], per_page: 10)
    end

end
