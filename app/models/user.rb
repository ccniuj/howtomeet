class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :meetup_members
  has_many :meetups, as: :meetable, through: :meetup_members, dependent: :destroy

  has_many :attendees
  has_many :events, through: :attendees, dependent: :destroy
  
  has_many :review, as: :reviewable, dependent: :destroy

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           name: data["name"],
           email: data["email"],
           uid: data["email"].split('@')[0].split('.')[0].to_s + data["email"].split('@')[0].split('.')[1].to_s,
           thumbnail: data["image"],
           picture: data["image"].split('=')[0]+'=200',
           provider: access_token.provider,
           token: access_token.credentials.token,
           password: Devise.friendly_token[0,20], 
           is_admin: false
        )
        if user.uid == "howtomeettw"
          binding.pry
          user.update(:is_admin => true)
        end
    else
      user.update(:token => access_token.credentials.token)
    end
    user
  end

  extend FriendlyId
  friendly_id :uid, use: :slugged
  
end
