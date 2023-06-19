class Image < ApplicationRecord
  has_one_attached :picture
  belongs_to :uploader, class_name: "User"

  validates_presence_of :picture
end
