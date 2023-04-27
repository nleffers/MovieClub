describe 'User Remove From Watchllist Endpoint', type: :request do
  let(:user) do
    create(
      :user,
      movie_watchlist: [
        {
          'tmdb_movie_id' => 453_395,
          'movie_title' => 'Doctor Strange in the Multiverse of Madness',
          'movie_poster_path' => '/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg'
        }.to_json
      ]
    )
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = user
  end

  describe 'users#remove_from_watchlist' do
    it 'removes a movie from the watchlist' do
      expect(user.movie_watchlist.count).to eq(1)

      put "/users/#{user.id}/remove_from_watchlist", params: { tmdb_movie_id: 453_395 }, as: :json

      user.reload
      expect(user.movie_watchlist.count).to eq(0)
    end
  end
end
