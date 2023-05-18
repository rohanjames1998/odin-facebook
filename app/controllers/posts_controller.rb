class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', @post)}
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:text_content)
  end

end
