RSpec.describe 'Auth - Post Session Id', type: :request do
  it 'update user with session id' do
    user = create(:user, token: 'fakerequesttoken', tmdb_id: 1)
    allow_any_instance_of(TheMovieDb).to receive(:get_session_id).and_return(
      {
        code: 200,
        body: {
          'session_id' => 'session_id'
        }
      }
    )

    post '/auth/session_id', params: { request_token: user.token }

    expect(JSON.parse(response.code)).to eq(200)
    result = JSON.parse(response.body)
    expect(result['username']).to eq(user.username)
  end

  it 'denies user session if request token is bad' do
    user = create(:user, token: 'fakerequesttoken', tmdb_id: 1)
    allow_any_instance_of(TheMovieDb).to receive(:get_session_id).and_return(
      JSON.parse(File.read('spec/fixtures/files/bad_session_id_response.json')).symbolize_keys
    )

    post '/auth/session_id', params: { request_token: user.token }

    expect(JSON.parse(response.code)).to eq(401)
  end
end
