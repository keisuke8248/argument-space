class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :groups
  has_many :favorites

  validates :nickname, presence: true, length: {maximum: 8}
  validates :email, presence: true
  validates :password, presence: true
end
