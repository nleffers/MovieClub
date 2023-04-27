# Represents a User
class User < ApplicationRecord
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :password_digest, presence: true
  has_secure_password

  has_many :movie_reviews, dependent: :destroy
  has_one_attached :avatar

  serialize :movie_watchlist, Array

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
