class Meetup < ActiveRecord::Base
  belongs_to :meetable, polymorphic: true, dependent: :destroy

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
  validates :called, :presence => "true"
  validates_presence_of :cover, :on => :create
 
  extend FriendlyId
  friendly_id :title_en, use: :slugged

  def total
    self.users.count
  end

  def is_owned?(user)
    MeetupMember.where(meetup_id: self.id, user_id: user.id, is_owner: true).take ? true : false
  end

  def is_member?(user)
    MeetupMember.where(meetup_id: self.id, user_id: user.id).take ? true : false
  end

  def create_member(user)
    MeetupMember.create(meetup_id: self.id, user_id: user.id, is_owner: true)
  end

  def add_member(user)
    MeetupMember.create(meetup_id: self.id, user_id: user.id, is_owner: false)
  end

  def remove_member(user)
    MeetupMember.where(meetup_id: self.id, user_id: user.id).take.delete
    self.events.each{ |event| 
      attendee = Attendee.where(event_id: event.id, user_id: user.id).take
      attendee.delete if attendee
    }
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
