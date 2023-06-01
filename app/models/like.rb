class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
  has_one :notification, as: :notifiable, dependent: :delete

  accepts_nested_attributes_for :notification
end
