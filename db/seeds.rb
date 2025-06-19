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