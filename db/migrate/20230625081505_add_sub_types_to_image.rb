class AddSubTypesToImage < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :sub_type, :text, default: ""
  end
end
