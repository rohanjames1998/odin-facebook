
FactoryBot.define do

  factory :comment do
    author { association :user }
    text { association :text }
    post { association :post }
    trait :reply do
      parent_comment { association :comment }
    end
  end
end
