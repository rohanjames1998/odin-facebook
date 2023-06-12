class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    post = Post.find(params[:comment][:post_id]) 
     if @comment.save!
      Turbo::StreamsChannel.broadcast_action_to(
        "post_#{params[:comment][:post_id]}",
        action: :append,
        target: "comments"
        partial: "posts/post", locals: { comment: @comment, post: post}
      )
     end
  end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :parent_comment_id, :text_content)
    end
end
