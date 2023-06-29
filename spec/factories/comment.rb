FactoryBot.define do

  factory :comment do
    author { association :user }
    text { association :text }
    post { association :post }
  end
end
