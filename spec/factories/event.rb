FactoryGirl.define do
  factory :event do
    meetup_id ''
    subject Faker::Hacker.adjective
    subject_en Faker::Hacker.adjective
    content Faker::Lorem.paragraph
    date Faker::Time.forward(7, :morning)
    place Faker::Address.street_name
    price 50 + Random.rand(100)
    created_at Faker::Time.between(2.days.ago, Time.now, :morning)
    updated_at Faker::Time.between(2.days.ago, Time.now, :afternoon)
  end

end