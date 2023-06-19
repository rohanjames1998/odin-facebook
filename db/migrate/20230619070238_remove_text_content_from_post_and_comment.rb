class RemoveTextContentFromPostAndComment < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :text_content
    remove_column :comments, :text_content
  end
end
