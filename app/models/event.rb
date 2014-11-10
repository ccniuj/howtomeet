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
  validates :size, :presence => "true"
  
  extend FriendlyId
  friendly_id :subject_en, use: :slugged

  def should_generate_new_friendly_id?
    subject_en_changed?
  end

  def is_owned?(user)
    Attendee.where(event_id: self.id, user_id: user.id, is_owner: true).take ? true : false
  end

  def is_attendee?(user)
    Attendee.where(event_id: self.id, user_id: user.id).take ? true : false
  end

  def available
    self.size - self.users.count
  end

  def create_attendee(user)
    Attendee.create(event_id: self.id, user_id: user.id, is_owner: true)
    unless MeetupMember.where(meetup_id: self.meetup.id, user_id: user.id).take
      MeetupMember.create(meetup_id: self.meetup.id, user_id: user.id, is_owner: false)
    end
  end

  def add_attendee(user)
    Attendee.create(event_id: self.id, user_id: user.id, is_owner: false)
    unless MeetupMember.where(meetup_id: self.meetup.id, user_id: user.id).take
      MeetupMember.create(meetup_id: self.meetup.id, user_id: user.id, is_owner: false)
    end
  end

  def remove_attendee(user)
    Attendee.where(event_id: self.id, user_id: user.id).take.delete
  end
  
end
