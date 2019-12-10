FactoryBot.define do
  factory :test_post, class: Post do
    id {1}
    title { "test_title" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    evaluation { 1 }
    content { "test_content" }
    created_at { 3.years.ago }
    association :user, factory: :test_user
    association :prefecture, factory: :prefecture1
  end

  factory :test_post2, class: Post do
    id {2}
    title { "test_title2" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    evaluation { 1 }
    content { "test_content" }
    created_at { 3.days.ago }
    association :user, factory: :test_user2
    association :prefecture, factory: :prefecture1
  end

  factory :test_post3, class: Post do
    id {3}
    title { "test_title3" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    evaluation { 1 }
    content { "test_content" }
    created_at { 3.hours.ago }
    association :user, factory: :test_user3
    association :prefecture, factory: :prefecture1
  end

  factory :test_post4, class: Post do
    id {4}
    title { "test_title4" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    evaluation { 1 }
    content { "test_content" }
    created_at { Time.zone.now }
    association :user, factory: :test_user4
    association :prefecture, factory: :prefecture1
  end
end
