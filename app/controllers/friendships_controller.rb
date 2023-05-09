class FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.create(friendship_params)
    notification = @friendship.notifications.build
    @friendship.save
  end

  def destroy
    friendship = Friendship.find_by(request_sender_id: params[:request_sender_id], requested_user_id: params[:requested_user_id])
    friendship.destroy
  end

  private
  def friendship_params
    params.require(:friendship).permit(:requested_user_id, :request_sender_id, notifications_attributes: [:receiver_id, :sender_id])
  end
end
