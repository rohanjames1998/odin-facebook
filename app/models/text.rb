class Text < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :textable, polymorphic: true
  has_many :likes, as: :likeable

  validates :content, presence: true
end
