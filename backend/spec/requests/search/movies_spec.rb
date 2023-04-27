describe 'Search Endpoint - Movies' do
  it 'returns four lists of movies' do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    allow_any_instance_of(TheMovieDb).to receive(:search).and_return(
      JSON.parse(
        File.read('spec/fixtures/files/movie_search_response.json')
      ).symbolize_keys
    )

    params = {
      query: 'Batman'
    }

    get('/search/movies', params:)

    expect(response.status).to eq(200)

    results = JSON.parse(response.body)['results']
    expect(results.count).to eq(20)
  end
end
