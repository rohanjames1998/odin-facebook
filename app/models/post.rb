class Post < ApplicationRecord
  belongs_to :user
  enum :attachments, %i(unavailable available)

  validates :text_content, presence: true, if: :attachments_present?

  def attachments_present?
    available?
  end

  def self.relevant_posts(user)
    user.friends.map do |friend|
      Post.find_by("user_id = ?", friend.id)
    end
  end
end
