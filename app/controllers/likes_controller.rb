class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if already_liked?(like)
      head :forbidden
    else
      like.save!
      head :no_content
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
