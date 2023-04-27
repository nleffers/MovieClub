describe 'User Add To Watchllist Endpoint', type: :request do
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

  describe 'users#add_to_watchlist' do
    it 'adds a movie to the watchlist' do
      expect(user.movie_watchlist.count).to eq(1)

      params = {
        tmdb_movie_id: 526_896,
        movie_title: 'Morbius',
        movie_poster_path: '6JjfSchsU6daXk2AKX8EEBjO3Fm.jpg'
      }

      put("/users/#{user.id}/add_to_watchlist", params:, as: :json)

      user.reload
      expect(user.movie_watchlist.count).to eq(2)
    end
  end
end
