FactoryBot.define do
  factory :movie_review do
    sequence(:review_title, 'A') { |n| "#{n} Review Title" }
    sequence(:review_blog, 'A') { |n| "#{n} Review Blog" }
    sequence(:review_rating) { |n| n % 10 + 1 }
    sequence(:movie_title, 'A') { |n| "#{n} Movie Title" }
    sequence(:movie_release_date) do |n|
      "#{format('%04d', (2000 + n) % 10_000)}-#{format('%02d', n % 12 + 1)}-#{format('%02d', n % 12 + 1)}"
    end
    sequence(:movie_poster_path) { |n| "#{n}.jpg" }
    sequence(:tmdb_movie_id) { |n| n }
  end
end
