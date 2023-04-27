RSpec.describe 'Static Info - index', type: :request do
  it 'returns static info' do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    allow_any_instance_of(TheMovieDb).to receive(:get_api_configuration).and_return(
      JSON.parse(File.read('spec/fixtures/files/api_configuration.json')).symbolize_keys
    )

    get '/static_info/'

    expect(response.code.to_i).to eq(200)
  end
end
