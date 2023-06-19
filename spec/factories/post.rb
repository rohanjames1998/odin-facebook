FactoryBot.define do

  factory :post do
    author_id { FactoryBot.create(:user).id }
  end
end
