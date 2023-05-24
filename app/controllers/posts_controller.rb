class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      current_user.friends.each do |friend|
        ActionCable.server.broadcast("home_#{friend.id}", @post.as_json(include: :user))
      end
      ActionCable.server.broadcast("home_#{current_user.id}", @post.as_json(include: :user))
    end
  end

  private

  def post_params
    params.require(:post).permit(:text_content)
  end

end
