class SheetsController < ApplicationController
    def index
        @seats_by_row = Sheet.all.group_by(&:row).sort
    rescue => e
        flash.now[:alert] = "座席情報の取得に失敗しました"
        @seats_by_row = {}
    end

end