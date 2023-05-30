class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like_already_exists(like)
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

  def like_already_exists(like)
    if Like.where("user_id = ? and likeable_type = ? and likeable_id = ?", like.user_id, like.likeable_type, like.likeable_id).blank?
      return false
    end
    return true
  end
end
