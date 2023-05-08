class UsersController < ApplicationController
  def home
    @user = User.find(params[:user_id])
  end

  def index
    @users = User.all
  end

  def root
    if user_signed_in?
      redirect_to user_home_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end

  def friends
    @friends = current_user.friends
  end
end
