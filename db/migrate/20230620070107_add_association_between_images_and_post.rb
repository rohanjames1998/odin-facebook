class AddAssociationBetweenImagesAndPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :images, :post, foreign_key: true
  end
end
