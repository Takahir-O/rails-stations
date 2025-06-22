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

end
