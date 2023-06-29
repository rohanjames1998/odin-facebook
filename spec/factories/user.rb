FactoryBot.define do


  factory :user do
    after(:build) { |user| user.class.skip_callback(:create, :after, :add_default_profile, raise: false)}

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password(min_length: 8) }
    email { Faker::Internet.email }

    trait :with_profile do
      profile { association :profile }
    end
  end

end
