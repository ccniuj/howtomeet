class Meetup < ActiveRecord::Base
  belongs_to :meetable, polymorphic: true
  has_many :events
end
