class Category < ActiveRecord::Base
  has_many :meetups, as: :meetable
end
