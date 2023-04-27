# Responsible for serializing User for show endpoint
class User::LoginSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
             :username,
             :session_id,
             :first_name,
             :last_name,
             :email,
             :avatar,
             :bio,
             :memberSince,
             :ratings,
             :reviews,
             :watchlist

  def avatar
    return nil unless object.avatar.attached?

    rails_blob_url(object.avatar)
  end

  def memberSince
    object.created_at.strftime('%B %Y')
  end

  def ratings
    JSON.parse(ActiveModelSerializers::SerializableResource.new(object.movie_reviews.where.not(review_rating: nil),
                                                                each_serializer: MovieReviewSerializer).to_json)
  end

  def reviews
    JSON.parse(ActiveModelSerializers::SerializableResource.new(object.movie_reviews.where.not(review_title: nil),
                                                                each_serializer: MovieReviewSerializer).to_json)
  end

  def watchlist
    object.movie_watchlist.map { |movie| JSON.parse(movie) }
  end
end
