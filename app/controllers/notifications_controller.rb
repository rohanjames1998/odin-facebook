class NotificationsController < ApplicationController

  def create
    flash.now[:alert] = "Sent Successfully!"
  end
end
