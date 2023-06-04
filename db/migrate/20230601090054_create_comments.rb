class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :parent_comment, null: true, foreign_key: { to_table: :comments }
      t.string :text_content, default: ""
      t.belongs_to :post, null: true
      t.check_constraint "(post_id IS NOT NULL AND parent_comment_id IS NULL) OR
      (post_id IS NULL AND parent_comment_id IS NOT NULL)", name: "check_comment_belongs_to_post_or_parent_comment"
      t.timestamps
    end
  end
end
