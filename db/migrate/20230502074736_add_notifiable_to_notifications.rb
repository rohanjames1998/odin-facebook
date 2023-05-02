class AddNotifiableToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :notifiable, polymorphic: true, index: true
    remove_column :notifications, :kind
  end
end
