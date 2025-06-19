class Movie < ApplicationRecord
  # 必須項目のバリデーション
  validates :name, presence: true, length: { maximum: 160 }, uniqueness: true
  validates :is_showing, inclusion: { in: [true, false] }
  
  # 任意項目のバリデーション
  validates :year, length: { maximum: 45 }, allow_blank: true
  validates :image_url, length: { maximum: 150 }, allow_blank: true
  validates :description, presence: false
end