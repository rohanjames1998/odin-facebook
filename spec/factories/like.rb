FactoryBot.define do

  factory :like do
    user_id { FactoryBot.create(:user).id }
    likeable_type { "Post" }
    likeable_id { FactoryBot.create(:post).id }
  end
end
