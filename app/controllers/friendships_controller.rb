class FriendshipsController < ApplicationController

  def create
    friendship = Friendship.new(friendship_params)
    friendship.notifications.build(params[:friendship][:notifications_attributes])
    friendship.save
    redirect_to users_path
  end

  private
  def friendship_params
    params.require(:friendship).permit(:requested_user_id, :request_sender_id, notifications_attributes: [:receiver_id, :sender_id])
  end
end
