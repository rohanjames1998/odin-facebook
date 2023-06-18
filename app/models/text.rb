class Text < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :textable, polymorphic: true

  validates :content, presence: true
end
