class FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.create(friendship_params)
    @friendship.notifications.build
    @friendship.save
  end

  def destroy
    friendship = Friendship.find_by(request_sender_id: params[:request_sender_id], requested_user_id: params[:requested_user_id])
    friendship.destroy
  end

  def update
    friendship = Friendship.find(params[:id])

    if params[:status] == "accepted"
      friendship.notifications.build(sender_id: params[:sender_id], receiver_id: params[:receiver_id])
    end

    friendship.update!(status: params[:status])
  end

  private
  def friendship_params
    params.require(:friendship).permit(:requested_user_id, :request_sender_id, notifications_attributes: [:receiver_id, :sender_id])
  end
end
