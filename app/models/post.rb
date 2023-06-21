class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_one :text, as: :textable, dependent: :delete
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :images

  enum :attachments, %i(unavailable available)

  validates_associated :text

  validates_presence_of :text, if: :attachments_present?

  accepts_nested_attributes_for :text
  accepts_nested_attributes_for :images



  def attachments_present?
    available?
  end

  def self.relevant_posts(user)
    posts = user.friends.map do |friend|
      Post.where("author_id = ?", friend.id).to_a
    end
    posts.flatten
  end
end
