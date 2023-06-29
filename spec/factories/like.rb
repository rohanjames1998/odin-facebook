FactoryBot.define do

  factory :like do
    user { association :user }
    likeable_type { "Post" }
    likeable_id { FactoryBot.create(:post).id }
  end
end
