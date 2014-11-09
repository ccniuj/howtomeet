FactoryGirl.define do
  factory :attendee do
    association :user
    association :event
  end
end