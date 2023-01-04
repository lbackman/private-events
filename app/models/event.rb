class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invites
  has_many :attendees, through: :invites, source: :attendee
  # todo: creator should not be able to invite themselves
end
