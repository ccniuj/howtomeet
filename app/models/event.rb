class Event < ActiveRecord::Base
  belongs_to :meetup
  has_many :attendees
  has_many :users, through: :attendees, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :images

  validates :subject, :presence => "true"
  validates :subject_en, :presence => "true"
  validates :content, :presence => "true"
  validates :place, :presence => "true"
  validates :date, :presence => "true"
  validates :price, :presence => "true"
  
  extend FriendlyId
  friendly_id :subject_en, use: :slugged
  
end
