class Admin::ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]

    def index
        @reservations = Reservation
            .joins(schedule: :movie,sheet: {})
        
        # テスト環境以外では将来の予約のみ表示
        unless Rails.env.test?
            @reservations = @reservations
                .where('reservations.date > ? OR (reservations.date = ? AND TIME(schedules.start_time) > ?)',
                    Date.today, Date.today, Time.current.strftime('%H:%M:%S'))
        end
        
        @reservations = @reservations
            .includes(schedule: :movie,sheet:{})
            .order('reservations.date ASC, schedules.start_time ASC')
    end

    def new
        @reservation = Reservation.new
    end

    def create
        @reservation = Reservation.new(reservation_params)

        if @reservation.save
            redirect_to admin_reservations_path,notice: "予約が作成されました。"
        else
            render :new,status: :bad_request
        end
    rescue ActiveRecord::RecordNotUnique
        @reservation.errors.add(:base,"その座席はすでに予約済みです。")
        render :new, status: :bad_request

    end

    def show
    end

    def edit
    end

    def update
        if params[:reservation][:schedule_id].present? &&
            params[:reservation][:sheet_id].present? &&
            params[:reservation][:name].present? &&
            params[:reservation][:email].present?

            if @reservation.update(reservation_params)
                redirect_to admin_reservations_path,notice: "予約が更新されました。"
            else
                render :show,status: :bad_request
            end

        else
            @reservation.errors.add(:base,"必要な情報が不足しています。")
            render :show,status: :bad_request
        end

        rescue ActiveRecord::RecordNotUnique
            @reservation.errors.add(:base,"その座席はすでに予約済みです。")
        render :show,status: :bad_request
    end

    def destroy
        @reservation.destroy
        redirect_to admin_reservations_path,notice: "予約が削除されました。"
    end

    private

    def set_reservation
        @reservation = Reservation.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to admin_reservations_path,alert: "予約が見つかりません。"
    end

    def reservation_params
        params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :name, :email)
    end




end
