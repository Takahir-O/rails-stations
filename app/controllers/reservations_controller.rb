class ReservationsController < ApplicationController
    def new
        if params[:date].blank? || params[:sheet_id].blank?
            redirect_to movie_path(params[:movie_id]) and return
        end
         
        @movie = Movie.find(params[:movie_id])
        @schedule = @movie.schedules.find(params[:schedule_id])
        @sheet = Sheet.find(params[:sheet_id])
        @date = Date.parse(params[:date])

        # すでに予約済かチェック
        if Reservation.exists?(
            schedule_id: @schedule.id,
            sheet_id: @sheet.id,
            date: @date
        )
        flash[:alert] = "その座席はすでに予約済みです"
        redirect_to reservation_movie_path(
            @movie,
            schedule_id: @schedule.id,
            date: @date
        )
        return
        end

        @reservation = Reservation.new

    rescue ActiveRecord::RecordNotFound
        flash[:alert] = "指定されたスケジュールが見つかりません"
        redirect_to movie_path(params[:movie_id])
    rescue ArgumentError
        flash[:alert] = "日付の形式が正しくありません"
        redirect_to movie_path(params[:movie_id])
    end

    def create
        # トランザクション内で予約処理を実行
        ActiveRecord::Base.transaction do
        @reservation = Reservation.new(reservation_params)

        # 保存直前に再度予約状況をチェック
        if Reservation.exists?(
            schedule_id:@reservation.schedule_id,
            sheet_id:@reservation.sheet_id,
            date:@reservation.date
        )
        raise ActiveRecord::RecordNotUnique, "その座席はすでに予約済みです"
        end

        if @reservation.save
            flash[:notice] = "予約が完了しました"
            redirect_to movie_path(@reservation.schedule.movie)
        else
            # movie_idを reservation の schedule 経由で取得
            movie_id = @reservation.schedule.try(:movie_id) || params.dig(:reservation, :movie_id) || params[:movie_id]
            @movie = Movie.find(movie_id) if movie_id
            @schedule = Schedule.find(params.dig(:reservation, :schedule_id)) if params.dig(:reservation, :schedule_id)
            @sheet = Sheet.find(params.dig(:reservation, :sheet_id)) if params.dig(:reservation, :sheet_id)
            @date = Date.parse(params.dig(:reservation, :date)) if params.dig(:reservation, :date)

            render :new,status: :bad_request
        end
        end  # transaction do ブロックの終了

    rescue ActiveRecord::RecordNotUnique
        flash[:alert] = "その座席はすでに予約済みです"
        # 適切な movie を取得
        movie_id = params.dig(:reservation, :movie_id) || params[:movie_id]
        movie = Movie.find(movie_id) if movie_id
        redirect_to reservation_movie_path(
            movie,
            schedule_id: params.dig(:reservation, :schedule_id),
            date: params.dig(:reservation, :date)
        )
    rescue => e
        flash[:alert] = "予約に失敗しました: #{e.message}"
        # movie_id を適切に取得
        movie_id = params.dig(:reservation, :movie_id) || params[:movie_id]
        redirect_to movie_path(movie_id)
    end

    private

    def reservation_params
        params.require(:reservation).permit(:name,:email,:schedule_id,:sheet_id,:date)
    end

end