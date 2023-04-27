describe 'User Login', type: :request do
  let(:user) { create(:user, :with_avatar) }

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

  describe 'user#login' do
    context 'when u/p is correct but session id is empty' do
      it 'returns request token to redirect to TheMovieDb' do
        params = {
          login: {
            username: user.username,
            password: user.username
          }
        }

        post('/users/login', params:)
        json = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(json['request_token']).to eq('requesttoken')
      end

      it 'returns successful json with existing session_id if User already has session_id' do
        session_id = 'session_id'
        user.update(session_id:)
        params = {
          login: {
            username: user.username,
            password: user.username
          }
        }

        post('/users/login', params:)
        json = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(json['session_id']).to eq(session_id)
        expect(json['id']).to be(user.id)
        expect(json['username']).to eq(user.username)
      end
    end

    context 'when password is wrong' do
      it 'returns error message' do
        params = {
          login: {
            username: user.username,
            password: 'wrong_password'
          }
        }

        post('/users/login', params:)
        json = JSON.parse(response.body)

        expect(response.code).to eq('401')
        expect(json['message']).to eq('Login Rejected')
      end
    end
  end
end
