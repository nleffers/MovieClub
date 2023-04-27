# Class to handle search queries
class SearchController < ApplicationController
  skip_before_action :verify_session_id

  def search_movies
    search_resp = TheMovieDb.new.search('movie', params[:query])

    render json: search_resp[:body], status: search_resp[:code]
  end
end
