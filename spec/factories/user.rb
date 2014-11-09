FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password {Faker::Internet.password(8)}
    name {Faker::Name.name}
    uid {Faker::Internet.user_name.split('.')[0]}
    thumbnail Faker::Avatar.image("user", "50x50")
    picture Faker::Avatar.image("user", "200x200")
    is_admin false
    # location
    # birthday
    # gender
    # bio
    # interest
    # provider
    # token
    created_at Faker::Time.between(2.days.ago, Time.now, :morning)
    updated_at Faker::Time.between(2.days.ago, Time.now, :afternoon)

    factory :user_with_meetup do
      ignore do
        meetup_count 1
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:meetup_member, evaluator.meetup_count, user_id: user.id)
      end
    end
  end

end