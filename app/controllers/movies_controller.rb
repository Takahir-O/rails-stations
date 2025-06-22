class MoviesController < ApplicationController
    def index
        @movies = Movie.all
        @movies = @movies.search_by_keyword(params[:keyword]) if params[:keyword].present?
        @movies = @movies.filter_by_showing(params[:is_showing]) if params[:is_showing].present?
    end
end
