class UsersController < ApplicationController
  def home
    @user = User.find(params[:id])
  end
end
