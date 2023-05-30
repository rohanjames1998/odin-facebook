module LikesHelper
  def already_liked?(like)
    if Like.where("user_id = ? and likeable_type = ? and likeable_id = ?", like.user_id, like.likeable_type, like.likeable_id).blank?
      return false
    end
    return true
  end
end
