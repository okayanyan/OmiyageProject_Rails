FactoryBot.define do
  factory :follow_relation1, class: FollowUser do
    association :following_user, factory: :test_user
    association :target_user, factory: :test_user2
  end

  factory :follow_relation2, class: FollowUser do
    association :following_user, factory: :test_user2
    association :target_user, factory: :test_user
  end

  factory :follow_relation3, class: FollowUser do
    association :following_user, factory: :test_user
    association :target_user, factory: :test_user3
  end

  factory :follow_relation4, class: FollowUser do
    association :following_user, factory: :test_user4
    association :target_user, factory: :test_user
  end

end
