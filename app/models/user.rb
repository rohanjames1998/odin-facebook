require "open-uri"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i(github google_oauth2)
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  has_many :notifications, foreign_key: :receiver_id, class_name: "Notification"
  has_many :sent_notifications, foreign_key: :sender_id, class_name: "Notification"
  has_many :friend_requests, foreign_key: :requested_user_id, class_name: "Friendship"
  has_many :friend_requests_sent, foreign_key: :request_sender_id, class_name: "Friendship"
  has_many :friends_i_added,  -> { where status: "accepted" }, foreign_key: :request_sender_id, class_name: "Friendship"
  has_many :friends_that_added_me,  -> { where status: "accepted"}, foreign_key: :requested_user_id, class_name: "Friendship"
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :texts, foreign_key: :author_id
  has_many :images, foreign_key: :uploader_id
  has_many :likes
  has_one :profile

  after_create :add_default_profile

  def name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def friends
    ids_of_friends_i_added = friends_i_added.map { |frndship| frndship.requested_user_id }
    ids_of_friends_that_added_me = friends_that_added_me.map { |frndship| frndship.request_sender_id }

    all_friends_ids = ids_of_friends_i_added + ids_of_friends_that_added_me

    User.find(all_friends_ids)
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      name = auth.info.name.split(' ')
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = name[0]
      user.last_name = name[1]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def add_default_profile
    email_address = self.email
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "https://www.gravatar.com/avatar/#{hash}"
    cover_loc = "#{Rails.root}/app/assets/images/default_cover.jpeg"
    avatar_loc = "#{Rails.root}/app/assets/images/#{self.id}_default_avatar.png"

    #downloading the avatar
    IO.copy_stream(URI.open(image_src), avatar_loc)

    user = User.find(self.id)

    profile = user.create_profile!
    # building and attaching avatar and cover.
    profile.build_avatar(uploader_id: user.id, sub_type: "profile_avatar")
    profile.build_cover(uploader_id: user.id, sub_type: "profile_cover")
    profile.avatar.picture.attach(io: File.open(cover_loc), filename: "#{self.id}_default_avatar.png", content_type: "image/jpeg")
    profile.cover.picture.attach(io: File.open(avatar_loc), filename: "default_cover.jpg", content_type: "image/png")
    user.profile.save!
  end

end
