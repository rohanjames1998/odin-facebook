class ApplicationController < ActionController::Base
  before_action :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_id, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def set_user_id
    cookies[:user_id] = current_user.id || nil
  end
end
