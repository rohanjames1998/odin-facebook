class Image < ApplicationRecord
  has_one_attached :picture
  belongs_to :imageable, polymorphic: true
  belongs_to :uploader, class_name: "User"
  has_many :likes, as: :likeable


  validates_presence_of :picture
end
