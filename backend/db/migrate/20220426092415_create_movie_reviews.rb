class CreateMovieReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_reviews do |t|
      t.string :review_title
      t.text :review_blog
      t.integer :review_rating
      t.string :tmdb_movie_id, nil: false
      t.index :tmdb_movie_id, unique: true

      t.timestamps
    end
  end
end
