FactoryBot.define do


  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    password { "password" }
    email { "john@example.com" }
  end

end
