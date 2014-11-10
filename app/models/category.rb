class Category < ActiveRecord::Base
  has_many :meetups, as: :meetable

  extend FriendlyId
  friendly_id :title_en, use: :slugged

  def should_generate_new_friendly_id?
    title_en_changed?
  end
end
