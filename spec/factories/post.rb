FactoryBot.define do

  factory :post do
    text_content { Faker::Quote.famous_last_words }
    user_id { FactoryBot.create(:user).id }
  end
end
