class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :events, foreign_key: 'creator_id'

  validates :username, uniqueness: true, length: { minimum: 4 }
  validates :email, uniqueness: true
end
