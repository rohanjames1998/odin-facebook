class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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


  def name
    "#{first_name} #{last_name}"
  end

  def friends
    ids_of_friends_i_added = friends_i_added.map { |frndship| frndship.requested_user_id }
    ids_of_friends_that_added_me = friends_that_added_me.map { |frndship| frndship.request_sender_id }

    all_friends_ids = ids_of_friends_i_added + ids_of_friends_that_added_me

    User.find(all_friends_ids)
  end

end
