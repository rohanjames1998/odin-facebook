class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.save!
  end

  private
    def comment_params
      params.require(:comment).permit(:author_id, :post_id, :parent_comment_id, :text_content)
    end
end
