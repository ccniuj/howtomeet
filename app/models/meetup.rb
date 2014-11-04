class Meetup < ActiveRecord::Base
  belongs_to :meetable, polymorphic: true

  has_many :meetup_members
  has_many :users, through: :meetup_members, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :review, as: :reviewable

  mount_uploader :cover, CoverUploader

  validates :title, :presence => "true"
  validates :title_en, :presence => "true"
  validates :description, :presence => "true"
  validates :location, :presence => "true"
  validates :day, :presence => "true"
  validates :category_id, :presence => "true"
  validates_presence_of :cover, :on => :create
 
  extend FriendlyId
  friendly_id :title_en, use: :slugged

  def is_owned?(user)
    MeetupMember.where(meetup_id: self.id, user_id: user.id, is_owner: true).take ? true : false
  end

  def weekday
    case self.day
    when 1 
      return "星期一"
    when 2
      return "星期二"
    when 3 
      return "星期三"
    when 4
      return "星期四"
    when 5 
      return "星期五"
    when 6
      return "星期六"
    when 7 
      return "星期日"
    end
  end
end
