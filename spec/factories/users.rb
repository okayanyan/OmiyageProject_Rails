FactoryBot.define do
  factory :test_user, class: User do
    id {1}
    name { "test_user" }
    email { "test@test.com" }
    password { "password" }
    activated {true}
    activated_at {Time.zone.now}
  end

  factory :test_user2, class: User do
    id {2}
    name { "test_user2" }
    email { "test2@test.com" }
    password { "password" }
    activated {true}
    activated_at {Time.zone.now}
  end

  factory :test_user3, class: User do
    id {3}
    name { "test_user3" }
    email { "test3@test.com" }
    password { "password" }
    activated {true}
    activated_at {Time.zone.now}
  end

  factory :test_user4, class: User do
    id {4}
    name { "test_user4" }
    email { "test4@test.com" }
    password { "password" }
    activated {true}
    activated_at {Time.zone.now}
  end

  factory :test_user_non_activate, class: User do
    id {4}
    name { "test_user" }
    email { "test@test.com" }
    password { "password" }
    activated {false}
    activated_at {Time.zone.now}
  end

end
