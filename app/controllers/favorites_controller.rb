class FavoritesController < ApplicationController

  def create
    # save just before page location
    set_just_before_location
    
    # favorite
    current_user.favorite(Post.find_by(id: favorite_params))

    # go back to just before page location
    redirect_to get_just_before_location
  end

  def destroy
    # save just before page location
    set_just_before_location

    # unfavorite
    current_user.unfavorite(Post.find_by(id: favorite_params))
    
    # go back to just before page location
    redirect_to get_just_before_location
  end

  private
    def favorite_params
      params.require(:post_id)
    end
end
