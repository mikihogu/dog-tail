# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'dog@dog',
  password: 'thedoggies'
)

(1..10).each do |n|
  Member.create!(email: "user#{n}@dog",
                 password: "password#{n}",
                 nickname: "user#{n}",
                 name: "username#{n}",
                 dog: "papillon",
                 introduction: "hello")
end

categories =  %w(ドッグラン 公園 カフェ 病院 他)

categories.each do |category|
  Category.create!(name: category)
end

tags = %w(ドッグラン 公園 カフェ 病院 ホテル 預かり所 大型犬OK 中型犬 小型犬 ワクチン接種証明 マナーパンツ必須 店内OK)

tags.each do |tag|
  Tag.create!(name: tag)
end
