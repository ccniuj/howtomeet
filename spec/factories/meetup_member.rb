FactoryGirl.define do
  factory :meetup_member do
    association :user
    association :meetup
  end
end