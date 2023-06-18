class CreateTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :texts do |t|
      t.string :content, null: false
      t.timestamps
    end
    add_reference :texts, :textable, polymorphic: true, index: true
    add_reference :texts, :author, foreign_key: { to_table: :users }
  end
end
