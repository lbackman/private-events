class Invite < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'User'

  validates :event, uniqueness: { scope: :attendee, message: "You can't invite a user more than once."}
end
