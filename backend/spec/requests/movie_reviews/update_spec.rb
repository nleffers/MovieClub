RSpec.describe 'MovieReview - Update' do
  let(:user) { create(:user) }
  let(:review) { create(:movie_review, user_id: user.id) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = user
  end

  it 'update a MovieReview' do
    params = {
      movie_review: {
        review_title: 'New Title',
        review_blog: 'New Blog'
      }
    }

    put("/movie_reviews/#{review.id}", params:)

    expect(MovieReview.last.review_title).to eq('New Title')
    expect(MovieReview.last.review_blog).to eq('New Blog')
  end

  it 'destroys a MovieReview if applicable' do
    params = {
      movie_review: {
        review_title: nil,
        review_blog: nil,
        review_rating: nil
      }
    }

    put("/movie_reviews/#{review.id}", params:)

    expect(MovieReview.count).to eq(0)
    expect(JSON.parse(response.code)).to eq(204)
  end
end
