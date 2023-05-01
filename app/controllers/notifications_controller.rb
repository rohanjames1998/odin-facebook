class NotificationsController < ApplicationController

  def create
    user = User.find(params[:receiver_id])
    notification = user.notifications.build(notification_params)
    notification.save!
    render "users/home", flash.now[:alert]= "Sent Succesfully"
  end
end
