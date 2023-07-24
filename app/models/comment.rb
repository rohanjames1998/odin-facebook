class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :post
  belongs_to :parent_comment, class_name: "Comment", optional: true

  has_one :text, as: :textable, dependent: :delete
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :notifications, as: :notifiable, dependent: :delete_all
  has_many :replies, foreign_key: "parent_comment_id", class_name: "Comment"

  validates_presence_of :text
  validates_associated :text

  accepts_nested_attributes_for :text

  def is_a_reply?
    if parent_comment_id != nil
      true
    else
      false
    end
  end
end
