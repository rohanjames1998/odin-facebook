class ProfilesController < ApplicationController
  def update
    profile = current_user.profile
    if profile.update(profile_params)
      update_avatar(params, profile)
      update_cover(params, profile)
      redirect_to user_path(current_user), notice: "Updated successfully!"
    else
      head :unprocessable_entity
    end
  end


  private

  def profile_params
    params.require(:profile).permit( :bio, :city, :country, :date_of_birth)
  end

  #Not sanitizing avatar or cover params because we have
  # separate methods to update those two.
  def update_avatar(params, profile)
    if params[:profile][:avatar].present?
      profile.avatar.picture.attach(params[:profile][:avatar][:picture])
    end
  end

  def update_cover(params, profile)
    if params[:profile][:cover].present?
      profile.cover.picture.attach(params[:profile][:cover][:picture])
    end
  end
end
