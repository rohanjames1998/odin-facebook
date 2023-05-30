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

  def destroy
    like = like.find_by(user_id: params[:user_id], likeable_type: params[:likeable_type], likeable_id: params[:likeable_id])
    like.destroy
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
