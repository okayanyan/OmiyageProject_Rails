FactoryBot.define do
  factory :test_user, class: User do
    name { "test_user" }
    email { "test@test.com" }
    password { "password" }
  end
end
