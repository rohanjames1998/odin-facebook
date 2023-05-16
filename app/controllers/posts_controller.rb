class PostsController < ApplicationController

  def create
    post = current_user.posts.build(post_params)
    post.save!
  end

  private

  def post_params
    params.require(:post).permit(:text_content)
  end

end
