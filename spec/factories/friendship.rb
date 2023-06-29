FactoryBot.define do

  factory :friendship do
    requested_user { association :user }
    request_sender { association :user }
    status { "accepted" }
  end
end
