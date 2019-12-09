FactoryBot.define do
  factory :test_user, class: User do
    id {1}
    name { "test_user" }
    email { "test@test.com" }
    password { "password" }
  end

  factory :test_user2, class: User do
    id {2}
    name { "test_user2" }
    email { "test2@test.com" }
    password { "password" }
  end
end
