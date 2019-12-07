FactoryBot.define do
  factory :test_post do
    user_id { 1 }
    title { "test_title" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    prefecture_id { 1 }
    evaluation { 1 }
    detail { "test_content" }
    created_at { 3.years.ago }
  end

  factory :test_post2 do
    user_id { 1 }
    title { "test_title2" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    prefecture_id { 1 }
    evaluation { 1 }
    detail { "test_content" }
    created_at { 3.days.ago }
  end

  factory :test_post3 do
    user_id { 1 }
    title { "test_title3" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    prefecture_id { 1 }
    evaluation { 1 }
    detail { "test_content" }
    created_at { 3.hours.ago }
  end

  factory :test_post4 do
    user_id { 1 }
    title { "test_title4" }
    image_key { "static/Miyalog/image/no_image.jpg" }
    prefecture_id { 1 }
    evaluation { 1 }
    detail { "test_content" }
    created_at { Time.zone.now }
  end
end
