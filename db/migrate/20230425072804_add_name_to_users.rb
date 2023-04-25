class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, limit: 20, default: "", null: false
    add_column :users, :last_name, :string, limit: 20, default: "", null: false
  end
end
