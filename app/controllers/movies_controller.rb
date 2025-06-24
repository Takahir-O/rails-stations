class MoviesController < ApplicationController
    def index
        @movies = Movie.all
        @movies = @movies.search_by_keyword(params[:keyword]) if params[:keyword].present?
        @movies = @movies.filter_by_showing(params[:is_showing]) if params[:is_showing].present?
    end

    def show
        @movie = Movie.find(params[:id])
        @schedules = @movie.schedules
    rescue ActiveRecord::RecordNotFound
        flash[:alert] =  '指定された映画が見つかりません'
        redirect_to movies_path
    end

    def reservation
        @movie = Movie.find(params[:id])
        @sheets = Sheet.all
        # クエリパラメータの検証
        if params[:schedule_id].blank?
            flash[:alert] = "スケジュールを選択してください"
            redirect_to movie_path(@movie) and return
        end

        if params[:date].blank?
            flash[:alert] = "日付を選択してください"
            redirect_to movie_path(@movie) and return
        end

        @schedule = @movie.schedules.find(params[:schedule_id])
        # スケジュールのstart_timeから日付を取得
        @date = @schedule.start_time.to_date
        @seats = Sheet.all.order(:row, :column)

        # すでに予約済みの座席を取得
        @reserved_sheet_ids = Reservation.where(
            schedule_id: @schedule.id,
            date: @date
        ).pluck(:sheet_id)

    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "指定されたスケジュールが見つかりません"
        redirect_to movie_path(@movie)
    end

end
