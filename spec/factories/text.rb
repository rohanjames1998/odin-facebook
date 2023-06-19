FactoryBot.define do

  factory :text do
    content { Faker::Quote.famous_last_words }
    author_id { FactoryBot.create(:user).id }
    textable_type { "Post" }
    textable_id { FactoryBot.create(:post).id }
  end
end
