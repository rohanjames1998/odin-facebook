class Post < ApplicationRecord
  belongs_to :user
  enum :attachments, %i(not_present present)

  validates :text_content, presence: true, if: :attachments_present?

  def attachments_present?
    present?
  end
end
