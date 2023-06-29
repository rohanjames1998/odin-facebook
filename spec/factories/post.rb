FactoryBot.define do

  factory :post do
    author { association :user }
  end
end
