FactoryBot.define do

  factory :comment do
    author_id { FactoryBot.create(:user).id }
    text nil
    post_id { FactoryBot.create(:post).id }
  end
end
