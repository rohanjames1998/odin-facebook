class HomeChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "home_#{params[:room]}"
  end
end
