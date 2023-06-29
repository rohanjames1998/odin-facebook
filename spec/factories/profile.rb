FactoryBot.define do

  factory :profile do
    bio { Faker::Quote.famous_last_words }
    date_of_birth { Faker::Date.in_date_period(year: 1998, month: 6) }
    city { "Delhi" }
    country { "India" }
    user { association :user }
    avatar { association :image, sub_type: "profile_avatar" }
    cover { association :image, sub_type: "profile_cover" }
  end
end
