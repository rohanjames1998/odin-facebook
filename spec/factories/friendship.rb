FactoryBot.define do

  factory :friendship do
    requested_user_id { FactoryBot.create(:user).id }
    request_sender_id { FactoryBot.create(:user).id }
    status { "accepted" }
  end
end
