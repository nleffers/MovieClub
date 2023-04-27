# Controller for Movies
class MoviesController < ApplicationController
  before_action :initialize_tmdb
  before_action :get_tmdb_configuration
  before_action :get_movie, only: %i[show]

  def home
    popular_movies = parse_results(@tmdb.get_movies('popular'))
    trending_movies = parse_results(@tmdb.get_trending_media('movie', 'week'))
    now_playing_movies = parse_results(@tmdb.get_movies('now_playing'))
    upcoming_movies = parse_results(@tmdb.get_movies('upcoming'))
    movies = {
      popular: popular_movies,
      trending: trending_movies,
      now_playing: now_playing_movies,
      upcoming: upcoming_movies
    }

    render json: movies, status: :ok
  end

  def show
    get_movie_response

    render json: @movie
  end

  def get_videos
    title = @tmdb.get_movie(params[:id])[:body]['title']
    videos = parse_results(@tmdb.get_movie_videos(params[:id]))

    render json: { title:, videos: }, status: :ok
  end

  private

  def initialize_tmdb
    @tmdb = TheMovieDb.new
  end

  # Should cache this info or store it permanently or something
  def get_tmdb_configuration
    config_resp = @tmdb.get_api_configuration
    return unless config_resp[:code] == 200

    @configuration = config_resp[:body]
  end

  def get_movie
    movie_resp = @tmdb.get_movie(params[:id])
    return unless movie_resp[:code] == 200

    @movie = movie_resp[:body]
  end

  def get_movie_response
    id = @movie['id']
    @movie['reviews'] = movie_reviews(id)
    @movie['credits'] = movie_credits(id)
    @movie['images'] = movie_images(id)
    @movie['videos'] = movie_videos(id)
    @movie['similar_movies'] = movie_similar_movies(id)
    @movie['watch_providers'] = movie_watch_providers(id)
  end

  def movie_reviews(id)
    MovieReview.where(tmdb_movie_id: id)
  end

  def movie_credits(id)
    @tmdb.get_movie_credits(id)[:body]
  end

  def movie_images(id)
    @tmdb.get_movie_images(id)[:body]
  end

  def movie_videos(id)
    parse_results(@tmdb.get_movie_videos(id))
  end

  def movie_similar_movies(id)
    parse_results(@tmdb.get_movie_similar(id))
  end

  def movie_watch_providers(id)
    parse_results(@tmdb.get_movie_watch_providers(id))['US']
  end

  def parse_results(resp)
    resp[:body]['results']
  end
end
