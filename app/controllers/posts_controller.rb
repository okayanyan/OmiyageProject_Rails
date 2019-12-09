class PostsController < ApplicationController
  before_action :check_logged_in, only:[:new, :create, :edit, :update, :destroy]
  before_action :check_correct_user, only:[:new, :create, :edit, :update, :destroy]

  def index
    @post = Post.paginate(page: params[:page], per_page: 10)
  end

  def show
    # TODO
    #   お気に入り投稿の実装後にジョインも組み込む
    @post = Post.joins(:user).joins(:prefecture).\
      select("posts.*, users.name as user_name, prefectures.name as prefecture_name").find_by(params[:id])
  end

  def new
    @post = Post.new
    @prefecture = Hash.new()
    Prefecture.all.each {|p| @prefecture[p.name]=p.id}
    @evaluation = [1, 2, 3, 4, 5]
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

  end

  def update

  end

  def destroy

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
        session[:post_prefecture] = @post.prefecture
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
    def get_create_user_info
      if session[:post_title]
        @post.title = session[:post_title]
        session.delete(:post_title)
      end
      if session[:post_prefecture]
        @post.prefecture = session[:post_prefecture]
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
    def has_create_user_info?
      !(session[:post_title].nil? && session[:post_prefecture].nil? && \
        session[:post_evaluation] && session[:post_content])
    end

end
