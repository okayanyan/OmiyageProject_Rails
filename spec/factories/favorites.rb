FactoryBot.define do
  factory :test_favorite, class: Favorite do
    association :user, factory: :test_user
    association :post, factory: :test_post2
  end
end
