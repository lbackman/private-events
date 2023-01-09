class Invite < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'User'

  validates :event_id, uniqueness: { scope: :attendee_id, message: "can't have more than one invite per attendee."}

  scope :accepted, ->(event) { where(event_id: event.id, accepted: true) }

  scope :pending,  ->(event) { where(event_id: event.id, accepted: nil) }
end
