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

  scope :attending,   ->(event) { where(id: event.invites.where(accepted: true).pluck(:attendee_id)) }

  scope :pending,     ->(event) { where(id: event.invites.where(accepted: nil).pluck(:attendee_id)) }

  scope :all_others,  ->(user) { where.not(id: user.id) }

  scope :not_invited, ->(event_id) { where.not(id: Invite.where(event_id: event_id).pluck(:attendee_id)) }
end
