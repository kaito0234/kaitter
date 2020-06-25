class LikesController < ApplicationController
before_action :logged_in_user

  def create
    like = current_user.likes.build(micropost_id: params[:micropost_id])
    like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    like.destroy
    redirect_back(fallback_location: root_path)
  end
end
