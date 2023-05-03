class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_reference :friendships, :requested_user, references: :users, index: true
    add_reference :friendships, :request_sender, references: :users, index: true
    add_foreign_key :friendships, :users, column: :requested_user_id
    add_foreign_key :friendships, :users, column: :request_sender_id
  end
end
