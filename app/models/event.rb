class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, source: :attendee
end
