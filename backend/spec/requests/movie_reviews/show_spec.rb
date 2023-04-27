RSpec.describe 'MovieReview - Show' do
  it 'creates a MovieReview' do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = create(:user)
    movie_review = create(:movie_review, user_id: User.current.id)

    get "/movie_reviews/#{movie_review.id}"

    result = JSON.parse(response.body)
    expect(result['review_title']).to eq(movie_review.review_title)
  end

  it 'returns 404 if MovieReview not found' do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = create(:user)
    movie_review = create(:movie_review, user_id: User.current.id)

    get "/movie_reviews/#{movie_review.id + 1}"

    expect(JSON.parse(response.code)).to eq(404)
  end
end
