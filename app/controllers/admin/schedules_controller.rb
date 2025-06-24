class Admin::SchedulesController < ApplicationController
    before_action :set_schedule, only: [:edit, :update, :destroy]
    # スケジュール一覧を表示するメソッド
    # 映画とそのスケジュールの情報をまとめて取得する
    def index
        # 映画とスケジュールを一緒に取得して、@movies_with_schedulesという変数に保存
        @movies_with_schedules = Movie.joins(:schedules).distinct.includes(:schedules)
    end

    # 新しいスケジュールを作るためのフォームを表示するメソッド
    def new
        # URLから映画のIDを取得して、その映画を探す
        @movie = Movie.find(params[:movie_id])
        # その映画に関連する新しいスケジュールを準備する
        @schedule = @movie.schedules.build
    rescue ActiveRecord::RecordNotFound
        # もし映画が見つからなかった時のエラー処理
        flash[:alert] = "映画が見つかりません"
        redirect_to admin_movies_path 
    end

    # 新しいスケジュールを実際に作成するメソッド
    def create
        # フォームから送られてきた映画IDを取得して、その映画を探す
        @movie = Movie.find(params[:schedule][:movie_id])
        # フォームから送られてきた情報で新しいスケジュールを作る
        @schedule = @movie.schedules.build(schedule_params)

        # スケジュールの保存が成功したかチェック
        if @schedule.save
            # 成功した場合：成功メッセージを表示して映画の編集画面に戻る
            flash[:notice] = "スケジュールを作成しました"
            redirect_to edit_admin_movie_path(@movie)
        else
            # 失敗した場合：エラーメッセージを表示して作成フォームを再表示
            flash[:alert] = "スケジュールの作成に失敗しました"
            render :new, status: :unprocessable_entity
        end

    rescue ActiveRecord::RecordNotFound
        # もし映画が見つからなかった時のエラー処理
        flash[:alert] = "映画が見つかりません"
        redirect_to admin_movies_path
    end

    # スケジュールを編集するためのフォームを表示するメソッド
    def edit
        # スケジュールに関連する映画の情報を取得
        @movie = @schedule.movie
        
    end

    # スケジュールの情報を更新するメソッド
    def update
        # フォームから送られてきた情報でスケジュールを更新
        if @schedule.update(schedule_params)
            # 更新が成功した場合：成功メッセージを表示してスケジュール一覧に戻る
            flash[:notice] = "スケジュールを更新しました"
            redirect_to admin_schedules_path
        else
            # 更新が失敗した場合：エラーメッセージを表示して編集フォームを再表示
            flash[:alert] = "スケジュールの更新に失敗しました"
            render :edit, status: :bad_request
        end
    end

    # スケジュールを削除するメソッド
    def destroy
        # 削除する前に、そのスケジュールの映画情報を覚えておく
        movie = @schedule.movie
        # スケジュールを削除する
        @schedule.destroy
        # 削除成功メッセージを表示して、映画の編集画面に戻る
        flash[:notice] = "スケジュールを削除しました"
        redirect_to edit_admin_movie_path(movie)
    rescue => e
        # 削除に失敗した場合のエラー処理
        flash[:alert] = "スケジュールの削除に失敗しました"
        redirect_to admin_schedules_path
    end

    # ここから下は他のメソッドから使うためのプライベートメソッド
    private

    # IDからスケジュールを探すメソッド（現在は使われていない）
    def set_schedule
        # URLのIDパラメータからスケジュールを探す
        @schedule = Schedule.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        # スケジュールが見つからなかった場合のエラー処理
        flash[:alert] = "スケジュールが見つかりません"
        redirect_to admin_schedules_path
    end

    # フォームから送られてきた情報で安全に使えるものだけを取り出すメソッド
    def schedule_params
        # start_time（開始時刻）とend_time（終了時刻）とscreen_id（スクリーンID）とmovie_id（映画ID）を許可する
        params.require(:schedule).permit(:start_time, :end_time, :screen_id, :movie_id)
    end

    
end