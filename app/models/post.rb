class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes, as: :likeable, dependent: :delete_all
  enum :attachments, %i(unavailable available)

  validates :text_content, presence: true, if: :attachments_present?

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
