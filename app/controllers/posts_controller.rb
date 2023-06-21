class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)

    if post_has_any_text?
      @post.build_text(content: params[:post][:text][:content], author_id: current_user.id )
    end

    if post_has_any_images?
      add_images_to_post(@post)
    end

    if @post.save
      current_user.friends.each do |friend|
        Turbo::StreamsChannel.broadcast_action_to(
          "home_#{friend.id}",
          action: :prepend,
          target: "posts",
          partial: "posts/post", locals: { post: @post }
        )
      end
      # For broadcasting the post to user's homepage
      Turbo::StreamsChannel.broadcast_action_to(
        "home_#{current_user.id}",
        action: :prepend,
        target: "posts",
        partial: "posts/post", locals: { post: @post }
      )
    end
  end

  private

  def post_params
    params.require(:post).permit(text_attributes: [ :content ], image_attributes: [ pictures: [] ] )
  end

  def post_has_any_text?
    params[:post][:text][:content] != ""
  end

  def post_has_any_images?
    pic_arr = params[:post][:images][:pictures]
    if pic_arr.all?("")
      return false
    end
    return true
  end

  def add_images_to_post(post)
    pic_arr = params[:post][:images][:pictures]

    pic_arr.each do | pic |
      next if pic == ""
      post.images.build(picture: pic, uploader_id: current_user.id )
    end
  end
end
