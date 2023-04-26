class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true, length: { in: 3..20 }
  validates :last_name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

end