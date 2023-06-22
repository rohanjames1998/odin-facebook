class Profile < ApplicationRecord

  has_one :avatar, as: :imageable, class_name: "Image", dependent: :destroy
  has_one :cover, as: :imageable, class_name: "Image", dependent: :destroy
  belongs_to :user

  validates :bio, length: { maximum: 500 }



end
