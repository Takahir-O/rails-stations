# 座席情報を管理するためのモデル
class Sheet < ApplicationRecord
    has_many :reservations,dependent: :destroy
    belongs_to :screen

    validates :column,presence:true,inclusion: {in: 1..5}
    validates :row,presence:true,inclusion: {in: %w[a b c]}
    validates :row,uniqueness: {scope: [:column,:screen_id]}

    def seat_number
        "#{row}-#{column}"
    end

end