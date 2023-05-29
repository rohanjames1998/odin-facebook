class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    like.save
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
