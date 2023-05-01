class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :type,   null:false

      t.timestamps
    end
    add_reference :notifications, :receiver, references: :users, index: true
    add_reference :notifications, :sender, references: :users, index: true
    add_foreign_key :notifications, :users, column: :receiver_id
    add_foreign_key :notifications, :users, column: :sender_id
  end
end
