class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :post, optional: true
  belongs_to :parent_comment, class_name: "Comment", optional: true

  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :notifications, as: :notifiable, dependent: :delete_all
  has_many :replies, foreign_key: "parent_comment_id", class_name: "Comment"

  validates :text_content, presence: true
end
