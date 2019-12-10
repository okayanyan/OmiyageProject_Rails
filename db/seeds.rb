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
  password_confirmation: 'test',
  image_key: "static/Miyalog/image/image_thumbnail_person.jpeg")
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
    {id: 1, name: '北海道'},
    {id: 2, name: '青森'},
    {id: 3, name: '秋田'},
    {id: 4, name: '岩手'},
    {id: 5, name: '山形'},
    {id: 6, name: '宮城'},
    {id: 7, name: '福島'},
    {id: 8, name: '栃木'},
    {id: 9, name: '群馬'},
    {id: 10, name: '茨城'},
    {id: 11, name: '埼玉'},
    {id: 12, name: '千葉'},
    {id: 13, name: '東京'},
    {id: 14, name: '神奈川'},
    {id: 15, name: '新潟'},
    {id: 16, name: '石川'},
    {id: 17, name: '福井'},
    {id: 18, name: '富山'},
    {id: 19, name: '長野'},
    {id: 20, name: '岐阜'},
    {id: 21, name: '山梨'},
    {id: 22, name: '静岡'},
    {id: 23, name: '愛知'},
    {id: 24, name: '三重'},
    {id: 25, name: '奈良'},
    {id: 26, name: '和歌山'},
    {id: 27, name: '大阪'},
    {id: 28, name: '京都'},
    {id: 29, name: '兵庫'},
    {id: 30, name: '滋賀'},
    {id: 31, name: '鳥取'},
    {id: 32, name: '島根'},
    {id: 33, name: '岡山'},
    {id: 34, name: '広島'},
    {id: 35, name: '山口'},
    {id: 36, name: '香川'},
    {id: 37, name: '徳島'},
    {id: 38, name: '愛媛'},
    {id: 39, name: '高知」'},
    {id: 40, name: '福岡'},
    {id: 41, name: '佐賀'},
    {id: 42, name: '長崎'},
    {id: 43, name: '宮崎'},
    {id: 44, name: '熊本'},
    {id: 45, name: '大分'},
    {id: 46, name: '鹿児島'},
    {id: 47, name: '沖縄'},
  ]
)

# create post
100.times do |n|
  user = User.find_by(id: 1)
  prefecture = Prefecture.find_by(id: 1)
  Post.create!(id: n+1
               user: user,
               title: "title_test#{n+1}",
               prefecture: prefecture,
               evaluation: 1,
               content: "test_content#{n+1}",
               created_at: n.minutes.ago)
end
