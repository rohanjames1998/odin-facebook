class Post < ApplicationRecord
  belongs_to :user
  enum :attachments, %i(unavailable available)

  validates :text_content, presence: true, if: :attachments_present?

  def attachments_present?
    available?
  end
end
