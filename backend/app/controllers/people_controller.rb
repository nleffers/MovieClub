# Controller for People
class PeopleController < ApplicationController
  before_action :get_the_movie_db

  def show
    person = @tmdb.get_person(params[:id])[:body]
    person['images'] = @tmdb.get_person_images(params[:id])[:body]['profiles']
    person['movie_credits'] = get_movie_credits

    render json: person, status: :ok
  end

  private

  def get_the_movie_db
    @tmdb = TheMovieDb.new
  end

  def get_movie_credits
    credits = @tmdb.get_person_movie_credits(params[:id])[:body]
    sorted_cast = credits['cast'].sort { |a, b| b['release_date'] <=> a['release_date'] }
    sorted_crew = credits['crew'].sort { |a, b| b['release_date'] <=> a['release_date'] }

    { cast: sorted_cast, crew: sorted_crew }
  end
end
