class Movie < ApplicationRecord
  # 必須項目のバリデーション
  validates :name, presence: true, length: { maximum: 160 }, uniqueness: true
  validates :is_showing, inclusion: { in: [true, false] }
  
  # 任意項目のバリデーション
  validates :year, length: { maximum: 45 }, allow_blank: true
  validates :image_url, length: { maximum: 150 }, allow_blank: true
  validates :description, presence: false

  # 関連モデルの設定
  has_many :schedules, dependent: :destroy

  # keywordで検索する機能を追加
  scope :search_by_keyword, ->(keyword){
    where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }

  # 年で検索する機能
  scope :filter_by_showing, ->(is_showing){
    where(is_showing: is_showing=='1')
  }

  def showing?
    is_showing
  end

end