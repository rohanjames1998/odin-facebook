class Profile < ApplicationRecord

  has_one :avatar, -> { where(sub_type: "profile_avatar") }, as: :imageable, class_name: "Image", dependent: :destroy
  has_one :cover, -> { where(sub_type: "profile_cover") }, as: :imageable, class_name: "Image", dependent: :destroy
  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :cover
  belongs_to :user

  validates :bio, length: { maximum: 500 }



end
