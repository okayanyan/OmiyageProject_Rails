class PostsController < ApplicationController
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
    
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
