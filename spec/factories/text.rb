FactoryBot.define do

  factory :text do
    content { Faker::Quote.famous_last_words }
    author { association :user }
    textable_type { "Post" }
    textable_id { FactoryBot.create(:post).id }
  end
end
