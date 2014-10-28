class Meetup < ActiveRecord::Base
  belongs_to :meetable, polymorphic: true

  has_many :meetup_members
  has_many :users, through: :meetup_members, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :review, as: :reviewable

  mount_uploader :cover, CoverUploader

  validates :title, :presence => "true"
  validates :description, :presence => "true"
  validates :location, :presence => "true"
  validates :day, :presence => "true"
  validates :category_id, :presence => "true"
  validates_presence_of :cover

end
