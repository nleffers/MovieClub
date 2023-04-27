describe 'User API Create endpoints' do
  before do
    allow_any_instance_of(TheMovieDb).to receive(:get_request_token).and_return(
      {
        body: {
          'success' => true,
          'expires_at' => 24.hours.from_now.strftime('%Y-%m-%d %H:%M:%S %Z'),
          'request_token' => 'requesttoken'
        },
        code: 200
      }
    )
  end

  context 'when creating a user' do
    it 'creates a user successfully' do
      params = {
        user: {
          username: 'test',
          password: 'test',
          email: 'test@test.com',
          first_name: 'first',
          last_name: 'last'
        }
      }

      expect(User.count).to eq(0)

      post('/users/', params:)
      json = JSON.parse(response.body)

      expect(User.count).to eq(1)
      expect(response.code).to eq('200')
      expect(json['request_token']).to eq('requesttoken')
    end
  end
end
