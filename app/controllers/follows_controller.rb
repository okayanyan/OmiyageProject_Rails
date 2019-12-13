class FollowsController < ApplicationController

  def create
    # save just before page location
    set_just_before_location
    
    # follow
    current_user.follow(User.find_by(id: target_params))

    # go back to just before page location
    redirect_to get_just_before_location
  end

  def destroy
    # save just before page location
    set_just_before_location

    # unfollow
    params[:id] = params[:target_id]
    current_user.unfollow(User.find_by(id: target_params))
    
    # go back to just before page location
    redirect_to get_just_before_location
  end

  private
    def target_params
      params.permit(:id)[:id]
    end
end
