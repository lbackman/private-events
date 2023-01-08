class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, source: :attendee

  validates :date, comparison: { greater_than: Time.now, message: "of the event must be in the future!" }
end
