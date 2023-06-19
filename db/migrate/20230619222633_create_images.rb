class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|

      t.timestamps
    end
    add_reference :images, :uploader, foreign_key: { to_table: :users }
  end
end
