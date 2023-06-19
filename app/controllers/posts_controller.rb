class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if params[:post][:text][:content] != ""
      @post.build_text(content: params[:post][:text][:content], author_id: current_user.id )
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
    params.require(:post).permit(text_attributes: [ :content ] )
  end
end
