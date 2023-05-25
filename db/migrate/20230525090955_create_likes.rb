class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.timestamps
    end
    add_reference :likes, :likeable, polymorphic: true, index: true
  end
end
