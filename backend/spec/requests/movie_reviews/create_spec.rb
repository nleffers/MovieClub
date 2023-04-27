RSpec.describe 'MovieReview - Create' do
  it 'creates a MovieReview' do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = create(:user)

    expect(MovieReview.count).to eq(0)

    params = {
      movie_review: {
        review_title: 'Test Title',
        review_blog: 'Test Blog',
        review_rating: 10,
        movie_title: 'Test Movie',
        movie_poster_path: 'test_poster_path.jpg',
        movie_release_date: Time.current.strftime('%Y-%m-%d'),
        tmdb_movie_id: 1
      }
    }

    post('/movie_reviews', params:)

    expect(response.code.to_i).to eq(200)
    expect(MovieReview.count).to eq(1)
  end
end
