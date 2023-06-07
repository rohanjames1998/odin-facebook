class RemoveConstraintFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_check_constraint :comments, name: "check_comment_belongs_to_post_or_parent_comment"
  end
end
