FactoryGirl.define do
  factory :category do
    title {Faker::Hacker.adjective}

    factory :category_with_meetup do
      after(:create) do |category|
        FactoryGirl.create_list(:meetup_with_user, 3, category_id: category.id)
        # FactoryGirl.create(:meetup_with_event, category_id: category.id)
      end
    end

  end
end