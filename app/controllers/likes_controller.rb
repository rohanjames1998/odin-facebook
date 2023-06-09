class LikesController < ApplicationController
  def create
    like = current_user.likes.build(like_params)
    if helpers.already_liked?(like.likeable_type, like.likeable_id )
      # In the unlikely case where user has disabled their js and the unlike button doesn't
      # show up this will prevent duplicate likes.
      head :forbidden
    else
      like.build_notification(receiver_id: params[:like][:notification_attributes][:receiver_id],
                              sender_id: current_user.id)
      like.save
      helpers.add_likes_to_associated_models(like.likeable_type, like.likeable_id)
      head :no_content
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id,
                        likeable_type: params[:likeable_type],
                        likeable_id: params[:likeable_id])
    like.destroy!
  end

  private
  def like_params
    params.require(:like).permit(:likeable_type, :likeable_id, notification_attributes: [:receiver_id])
  end
end
