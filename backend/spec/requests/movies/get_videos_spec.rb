RSpec.describe 'Movies - Get Videos' do
  it 'returns videos for a given movie' do
    allow_any_instance_of(ApplicationController).to receive(:verify_session_id).and_return(true)
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow_any_instance_of(TheMovieDb).to receive(:get_api_configuration).and_return(
      JSON.parse(File.read('spec/fixtures/files/api_configuration.json')).symbolize_keys
    )
    allow_any_instance_of(TheMovieDb).to receive(:get_movie_videos).and_return(
      {
        body: {
          'results' => movie_response[:videos]
        }
      }
    )

    get '/movies/453395/videos'

    result = JSON.parse(response.body)
    expect(result['videos'].count).to eq(1)
    expect(result['videos'].first['type']).to eq('Trailer')
  end
end
