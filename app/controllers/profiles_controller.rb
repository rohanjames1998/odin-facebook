class ProfilesController < ApplicationController
  def update
    if current_user.profile.update!(params)
      redirect_to users_path(current_user), notice: "Updated successfully!"
    else
      head :unprocessable_entity
    end
  end


  private

  def profile_params
    params.require(:profile).permit( :bio, :city, :country, :date_of_birth, avatar:[ :picture ], cover: [ :picture ] )
  end

  # def make_new_profile(params)
  #   p params
  #   profile = current_user.build_profile
  #   profile.avatar.build(picture: params[:avatar][:picture], uploader_id: current_user.id, sub_type: "profile_avatar")

  #   profile.cover.build(picture: params[:profile][:cover][:picture], uploader_id: current_user.id, sub_type: "profile_cover")

  #   if profile.save!
  #     redirect_to users_path(current_user), notice: "Profile created!"
  #   else
  #     head :unprocessable_entity
  #   end
  # end
end
