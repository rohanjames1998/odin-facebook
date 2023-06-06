FactoryBot.define do

  factory :comment do
    text_content { Faker::Quote.famous_last_words }
    author_id { FactoryBot.create(:user).id }
    post_id { FactoryBot.create(:post).id }
  end
end
