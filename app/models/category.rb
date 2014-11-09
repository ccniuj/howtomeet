class Category < ActiveRecord::Base
  has_many :meetups, as: :meetable

  extend FriendlyId
  friendly_id :title_en, use: :slugged
end
