class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :events, foreign_key: :creator_id

  has_many :invites_received, class_name: 'Invite', foreign_key: :attendee_id
  has_many :attended_events, through: :invites_received, source: :event

  validates :username, uniqueness: true, length: { minimum: 4 }
  validates :email, uniqueness: true
end
