# 座席情報を管理するためのモデル
class Sheet < ApplicationRecord
    has_many :reservations,dependent: :destroy

    def seat_number
        "#{row}-#{column}"
    end

end