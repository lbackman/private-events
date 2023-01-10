class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, source: :attendee

  validates :date, comparison: { greater_than: Time.now, message: "of the event must be in the future!" }
  validates :location, presence: true

  scope :past,      -> { where("date < ?", Time.now).order(:date) }

  scope :future,    -> { where("date > ?", Time.now).order(:date) }

  scope :invitee,   ->(user) { joins(:invites).where('attendee_id = ?', user.id) }
  scope :accepted,  ->(user) { joins(:invites).where('attendee_id = ? AND accepted = ?', user.id, true) }
  scope :attended,  ->(user) { past.accepted(user) } 
  scope :attending, ->(user) { future.accepted(user) }
end
