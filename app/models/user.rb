class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meetup_members
  has_many :meetups, as: :meetable, through: :meetup_members

  has_many :review, as: :reviewable
end
