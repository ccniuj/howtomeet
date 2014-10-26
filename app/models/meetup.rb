class Meetup < ActiveRecord::Base
  belongs_to :meetable, polymorphic: true
  
  has_many :meetup_members
  has_many :users, through: :meetup_members
  has_many :events
end
