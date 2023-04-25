class UsersController < ApplicationController
  def home
    # p params
    @user = User.find(params[:user_id])
  end

  def root
    if user_signed_in?
      redirect_to user_home_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end
end
