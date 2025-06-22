# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Movie.create!([
  {
    name: "スターウォーズ",
    year: "1977",
    description: "遠い昔、遥か彼方の銀河系で...",
    image_url: "https://picsum.photos/300/400?random=1",
    is_showing: true
  },
  {
    name: "バック・トゥ・ザ・フューチャー",
    year: "1985", 
    description: "時間旅行の冒険",
    image_url: "https://picsum.photos/300/400?random=2",
    is_showing: true
  },
  {
    name: "ジュラシック・パーク",
    year: "1993",
    description: "恐竜が蘇る島",
    image_url: "https://picsum.photos/300/400?random=3",
    is_showing: false
  }
])

# 座席情報を作成

seats_data = [
  { column: 1, row: 'a' }, { column: 2, row: 'a' }, { column: 3, row: 'a' }, { column: 4, row: 'a' }, { column: 5, row: 'a' },
  { column: 1, row: 'b' }, { column: 2, row: 'b' }, { column: 3, row: 'b' }, { column: 4, row: 'b' }, { column: 5, row: 'b' },
  { column: 1, row: 'c' }, { column: 2, row: 'c' }, { column: 3, row: 'c' }, { column: 4, row: 'c' }, { column: 5, row: 'c' }
]


seats_data.each do |seat|
  Sheet.find_or_create_by(seat)
end

puts "シードデータの作成が完了しました"
puts "映画: #{Movie.count}件"
puts "座席: #{Sheet.count}件"