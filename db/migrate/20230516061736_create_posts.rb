class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :attachments, default: 0, null: false
      t.string :text_content, default: ""
      t.belongs_to :user
      t.timestamps
    end
  end
end
