class AddAttributesToMovieReview < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_reviews, :movie_title, :string
    add_column :movie_reviews, :movie_release_date, :string
    add_column :movie_reviews, :movie_poster_path, :string
  end
end
