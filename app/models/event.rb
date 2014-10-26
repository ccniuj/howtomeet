class Event < ActiveRecord::Base
  belongs_to :meetup
  has_many :attendees
  has_many :users, through: :attendees
  has_many :notes
  has_many :images
end
