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


# スクリーンの作成
puts "スクリーンの作成"
screens = []
3.times do |i|
  screens << Screen.find_or_create_by(name: "スクリーン#{i+1}")
end

puts "スクリーンの作成が完了しました"
puts "スクリーン: #{Screen.count}件"

# 各スクリーンに座席を作成する
puts "各スクリーンに座席を作成する"

screens.each do |screen|
  seats_data = [
    {column: 1,row: 'a'},{column: 2,row: 'a'},{column: 3,row: 'a'},{column: 4,row: 'a'},{column: 5,row: 'a'},
    {column: 1,row: 'b'},{column: 2,row: 'b'},{column: 3,row: 'b'},{column: 4,row: 'b'},{column: 5,row: 'b'},
    {column: 1,row: 'c'},{column: 2,row: 'c'},{column: 3,row: 'c'},{column: 4,row: 'c'},{column: 5,row: 'c'}
  ]
  seats_data.each do |seat|
    screen.sheets.find_or_create_by(seat)
  end
end

puts "各スクリーンに座席の作成が完了しました"
puts "座席: #{Sheet.count}件"


# 各スクリーンに異なる映画のスケジュールを作成する
puts "スケジュール作成中"

if Movie.exists?
  movies = Movie.where(is_showing: true).limit(3)

  movies.each_with_index do |movie,index|
    screen = screens[index]

    # 既存のスケジュールの削除
    movie.schedules.destroy_all
    
      # 新しいスケジュールを作成（スクリーンを指定）
    [
      {start_time: '10:00',end_time: '12:00'},
      {start_time: '13:00',end_time: '15:00'},
      {start_time: '16:00',end_time: '18:00'},
      {start_time: '19:00',end_time: '21:00'},
      {start_time: '22:00',end_time: '24:00'}
    ].each do |schedule_data|
      movie.schedules.create!(
        start_time: schedule_data[:start_time],
        end_time: schedule_data[:end_time],
        screen: screen
      )
    end
  end
end
