# 座席情報を管理するためのモデル
class Sheet < ApplicationRecord

    def seat_number
        "#{row}-#{column}"
    end

end