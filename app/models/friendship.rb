class Friendship < ApplicationRecord
  validates :requested_user_id, presence: true
  validates :request_sender_id, presence: true
  enum :status, %i(pending accepted)

  has_many :notifications, as: :notifiable, dependent: :delete_all
  belongs_to :requested_user, class_name: "User"
  belongs_to :request_sender, class_name: "User"

  accepts_nested_attributes_for :notifications
end
