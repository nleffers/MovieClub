# Controller for MovieReviews
class MovieReviewsController < ApplicationController
  before_action :get_movie_review, only: %i[show update]

  def create
    movie_review = MovieReview.create(**movie_review_params, user_id: User.current.id)

    render json: movie_review, status: :ok
  end

  def show
    render json: @movie_review, status: :ok
  end

  def update
    @movie_review.assign_attributes(**movie_review_params)
    if @movie_review.review_title || @movie_review.review_blog || @movie_review.review_rating
      @movie_review.save
      render json: @movie_review, status: :ok
    else
      @movie_review.destroy
      render status: :no_content
    end
  end

  private

  def get_movie_review
    @movie_review = MovieReview.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  end

  def movie_review_params
    params.require(:movie_review).permit(:review_title,
                                         :review_blog,
                                         :review_rating,
                                         :movie_title,
                                         :movie_release_date,
                                         :movie_poster_path,
                                         :tmdb_movie_id)
  end
end
