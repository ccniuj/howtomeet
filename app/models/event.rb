class Event < ActiveRecord::Base
  belongs_to :meetup
  has_many :attendees
  has_many :users, through: :attendees, dependent: :destroy
  has_many :notes
  has_many :images

  validates :subject, :presence => "true"
  validates :content, :presence => "true"
  validates :place, :presence => "true"
  validates :date, :presence => "true"
  validates :price, :presence => "true"

end
