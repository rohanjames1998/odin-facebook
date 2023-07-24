class CommentsController < ApplicationController
  def create
    post = Post.find(params[:comment][:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.build_text(content: params[:comment][:text][:content], author_id: current_user.id)
     if @comment.save
      stream_comment(@comment, params, post)
      send_notification(@comment, params[:comment][:parent_comment_id])
     else
      # Flash notifications with error.
     end
  end

  private
    def comment_params
      params.require(:comment).permit(:post_id, :parent_comment_id, text_attributes: [ :content ])
    end

    def stream_comment(comment, params, post)
      if params[:comment].has_key?(:parent_comment_id)
        parent_comment_replies_count = Comment.find(params[:comment][:parent_comment_id]).replies.count
        Turbo::StreamsChannel.broadcast_action_to(
          "post_#{params[:comment][:post_id]}",
          action: :append,
          target: "comment_#{params[:comment][:parent_comment_id]}",
          partial: "comments/reply", locals: {comment: @comment,
          post: post,
          reply_count: parent_comment_replies_count}
          )
       else
        Turbo::StreamsChannel.broadcast_action_to(
          "post_#{params[:comment][:post_id]}",
          action: :append,
          target: "comments",
          partial: "comments/comment", locals: { comment: @comment, post: post}
        )
       end
    end

    def send_notification(comment, parent_id)
      if parent_id == nil
        comment.notifications.create(receiver_id: comment.post.author_id, sender_id: current_user.id)
      else
        comment.notifications.create(receiver_id: Comment.find(parent_id).author_id, sender_id: current_user.id)
      end
    end
end
