class NotificationsController < ApplicationController

  def create
    user = User.find(params[:notification][:receiver_id])
    notification = user.notifications.build(notification_params)
    notification.save!
    flash.now[:alert] = "Sent Successfully!"
    render "users/home", status: :ok
  end

  private
  def notification_params
    params.require(:notification).permit(:kind, :sender_id, :receiver_id)
  end
end
