describe 'Movie API Show Endpoint' do
  it 'returns details and reviews for a movie' do
    allow_any_instance_of(ApplicationController).to receive(:verify_session_id).and_return(true)
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow_any_instance_of(TheMovieDb).to receive(:get_api_configuration).and_return(
      JSON.parse(File.read('spec/fixtures/files/api_configuration.json')).symbolize_keys
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_movie).and_return(
      {
        body: movie_response.stringify_keys,
        code: 200
      }
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_movie_credits).and_return({ body: movie_response[:credits] })
    allow_any_instance_of(TheMovieDb).to receive(:get_movie_images).and_return({ body: movie_response[:images] })
    allow_any_instance_of(TheMovieDb).to receive(:get_movie_videos).and_return(
      {
        body: {
          'results' => movie_response[:videos]
        }
      }
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_movie_similar).and_return(
      {
        body: {
          'results' => movie_response[:similar_movies]
        }
      }
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_movie_watch_providers).and_return(
      {
        body: {
          'results' => {
            'US' => movie_response[:watch_providers]
          }
        }
      }
    )
    user = create(:user)
    MovieReview.create(user_id: user.id,
                       tmdb_movie_id: 550,
                       review_title: 'test',
                       review_blog: 'test',
                       review_rating: 10)

    get '/movies/453395'

    expect(response.status).to eq(200)

    result = JSON.parse(response.body)
    expect(result['credits'].count).to be > 0
    expect(result['reviews'].count).to eq(1)
  end
end
