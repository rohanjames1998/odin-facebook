module LikesHelper
  def already_liked?(likeable_type, likeable_id)
    if Like.where("user_id = ? and likeable_type = ? and likeable_id = ?",
                  cookies[:user_id],
                  likeable_type,
                  likeable_id).blank?
      return false
    end
    return true
  end
end
