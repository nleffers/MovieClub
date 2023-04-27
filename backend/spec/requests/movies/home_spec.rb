describe 'Movie API Home Endpoints' do
  it 'returns five movies with trailer links' do
    allow_any_instance_of(ApplicationController).to receive(:verify_session_id).and_return(true)
    allow_any_instance_of(TheMovieDb).to receive(:get_api_configuration).and_return(
      JSON.parse(File.read('spec/fixtures/files/api_configuration.json')).symbolize_keys
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_trending_media).and_return(
      JSON.parse(File.read('spec/fixtures/files/trending_media_response.json')).symbolize_keys
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_movies).and_return(
      JSON.parse(File.read('spec/fixtures/files/popular_movies_response.json')).symbolize_keys
    )

    get '/home'

    expect(response.status).to eq(200)
    results = JSON.parse(response.body)

    expect(results['trending'].count).to eq(20)
    expect(results['upcoming'].count).to eq(20)
    expect(results['popular'].count).to eq(20)
    expect(results['now_playing'].count).to eq(20)
  end
end
