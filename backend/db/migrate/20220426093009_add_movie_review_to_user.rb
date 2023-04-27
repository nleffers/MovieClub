class AddMovieReviewToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :movie_reviews, :user, foreign_key: true
  end
end
