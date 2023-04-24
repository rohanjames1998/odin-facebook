class UsersController < ApplicationController
  def home
    # @user = User.find(params[:id])
  end

  def root
    if user_signed_in?
      redirect_to user_home_path
    else
      redirect_to new_user_session_path
    end
  end
end
