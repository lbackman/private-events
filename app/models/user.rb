class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :events, foreign_key: :creator_id, dependent: :delete_all

  has_many :invites_received, class_name: 'Invite', foreign_key: :attendee_id
  has_many :attended_events, through: :invites_received, source: :event

  validates :username, uniqueness: true, length: { minimum: 4 }
  validates :email, uniqueness: true

  def self.attending(event)
    where(id: event.invites.where(accepted: true).pluck(:attendee_id))
  end

  def self.pending(event)
    where(id: event.invites.where(accepted: nil).pluck(:attendee_id))
  end
end
