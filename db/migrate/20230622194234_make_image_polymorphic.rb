class MakeImagePolymorphic < ActiveRecord::Migration[7.0]
  def change
    remove_column :images, :post_id
    add_reference :images, :imageable, polymorphic: true, index: true
  end
end
