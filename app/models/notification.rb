class Notification < ApplicationRecord
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates :notifiable_id, presence: true
  validates :notifiable_type, presence: true
end
