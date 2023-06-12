class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      current_user.friends.each do |friend|
        # ActionCable.server.broadcast("home_#{friend.id}", @post.as_json(include: :author))
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
    params.require(:post).permit(:text_content)
  end

end
