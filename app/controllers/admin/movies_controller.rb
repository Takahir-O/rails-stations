class Admin::MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            flash[:notice] = '映画が登録されました.'
            redirect_to admin_movies_path
        else
            flash[:alert] = '映画の登録に失敗しました.'
            render :new,status: :bad_request
        end
    end

    def edit
        @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = '指定された映画が見つかりません'
        redirect_to admin_movies_path
    end


    def update
        @movie = Movie.find(params[:id])
        if @movie.update(movie_params)
            flash[:notice] = '映画が更新されました.'
            redirect_to admin_movies_path,status: :see_other
        else
            flash[:alert] = '映画の更新に失敗しました.'
            render :edit,status: :bad_request
        end
    rescue ActiveRecord::RecordNotFound
        flash[:alert] = '指定された映画が見つかりません'
        redirect_to admin_movies_path
    end

    def destroy
        @movie=Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = '映画が削除されました.'
        redirect_to admin_movies_path
    end
    


    private
    def movie_params
        params.require(:movie).permit(:name,:year,:description,:image_url,:is_showing)
    end

end