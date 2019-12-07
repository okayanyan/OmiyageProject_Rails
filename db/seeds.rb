# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create user
User.create!(
  name: 'test1',
  email: 'test1@test.com',
  password: 'test',
  password_confirmation: 'test')
99.times do |n|
  name  = "test#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# create prefecture
Prefecture.create!(
  [
    {name: '北海道'},
    {name: '青森'},
    {name: '秋田'},
    {name: '岩手'},
    {name: '山形'},
    {name: '宮城'},
    {name: '福島'},
    {name: '栃木'},
    {name: '群馬'},
    {name: '茨城'},
    {name: '埼玉'},
    {name: '千葉'},
    {name: '東京'},
    {name: '神奈川'},
    {name: '新潟'},
    {name: '石川'},
    {name: '福井'},
    {name: '富山'},
    {name: '長野'},
    {name: '岐阜'},
    {name: '山梨'},
    {name: '静岡'},
    {name: '愛知'},
    {name: '三重'},
    {name: '奈良'},
    {name: '和歌山'},
    {name: '大阪'},
    {name: '京都'},
    {name: '兵庫'},
    {name: '滋賀'},
    {name: '鳥取'},
    {name: '島根'},
    {name: '岡山'},
    {name: '広島'},
    {name: '山口'},
    {name: '香川'},
    {name: '徳島'},
    {name: '愛媛'},
    {name: '高知」'},
    {name: '福岡'},
    {name: '佐賀'},
    {name: '長崎'},
    {name: '宮崎'},
    {name: '熊本'},
    {name: '大分'},
    {name: '鹿児島'},
    {name: '沖縄'},
  ]
)

# create post
100.times do |n|
  user = User.find_by(id: 1)
  prefecture = Prefecture.find_by(id: 1)
  Post.create!(user: user,
               title: "title_test#{n+1}",
               image_key: "static/Miyalog/image/no_image.jpg",
               prefecture: prefecture,
               evaluation: 1,
               content: "test_content#{n+1}",
               created_at: n.minutes.ago)
end
