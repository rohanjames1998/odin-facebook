module LikesHelper
  def already_liked?(likeable_type, likeable_id)
    if Like.where("user_id = ? and likeable_type = ? and likeable_id = ?",
                  session[:current_user_id],
                  likeable_type,
                  likeable_id).blank?
      return false
    end
    return true
  end

  def add_likes_to_associated_models(type, id)
    # since user can only directly like either a post
    # or a comment we only have method to build likes
    # (for their associated models) for these two
    if type == "Post"
      add_likes_for_post_associated_models(id)
    else
      add_likes_for_comment_associated_models(id)
    end
  end

  private

  def add_likes_for_post_associated_models(id)
    post = Post.find(id)

    if post.text != nil
      post.text.likes.create!(user_id: session[:current_user_id], likeable_type: "Text", likeable_id: post.text.id )
    end

    if post.images.exists?
      post.images.each do |img|
        img.likes.create!(user_id: session[:current_user_id], likeable_type: "Text", likeable_id: img.id )
      end
    end
  end

  def add_likes_for_comment_associated_models(id)
    comment = Comment.find(id)

    comment.text.likes.create!(user_id: session[:current_user_id], likeable_type: "Text", likeable_id: comment.text.id )
  end
end
