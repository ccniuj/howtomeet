class Review < ActiveRecord::Base
  belongs_to :reviewalbe, polymorphic: :true
end
