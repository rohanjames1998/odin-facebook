class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.build_text(content: params[:comment][:text][:content], author_id: current_user.id)
    post = Post.find(params[:comment][:post_id])
    @comment.save
     unless params[:comment].has_key?(:parent_comment_id)
      Turbo::StreamsChannel.broadcast_action_to(
        "post_#{params[:comment][:post_id]}",
        action: :append,
        target: "comments",
        partial: "comments/comment", locals: { comment: @comment, post: post}
      )
     else
      parent_comment_replies_count = Comment.find(params[:comment][:parent_comment_id]).replies.count
      Turbo::StreamsChannel.broadcast_action_to(
        "post_#{params[:comment][:post_id]}",
        action: :append,
        target: "comment_#{params[:comment][:parent_comment_id]}",
        partial: "comments/reply", locals: {comment: @comment,
        post: post,
        reply_count: parent_comment_replies_count}
        )
     end
  end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :parent_comment_id, text_attributes: [ :content ])
    end
end
