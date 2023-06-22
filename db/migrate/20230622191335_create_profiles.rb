class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false
      t.string :bio, default: "", null: true
      t.string :city, default: "", null: true
      t.string :country, default: "", null: true
      t.date :date_of_birth, null: true

      t.timestamps
    end
  end
end
