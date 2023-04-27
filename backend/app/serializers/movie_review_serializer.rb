# Responsible for serializing Reviews
class MovieReviewSerializer < ActiveModel::Serializer
  attributes :id,
             :review_title,
             :review_blog,
             :review_rating,
             :tmdb_movie_id,
             :movie_title,
             :movie_year,
             :movie_poster_path,
             :created_at

  def movie_year
    object.movie_release_date[0..3]
  end

  def created_at
    object.created_at.strftime('%-d %B %Y')
  end
end
