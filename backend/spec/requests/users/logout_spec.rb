describe 'User Logout', type: :request do
  let(:user) { create(:user, session_id: 'session_id') }

  before do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = user
  end

  describe 'user#logout' do
    context 'when the user_id exists' do
      it 'deletes the token and returns a 200' do
        post "/users/#{User.current.id}/logout"

        expect(response.status).to eq(200)
        expect(user.session_id).to eq(nil)
        expect(User.current).to eq(nil)
      end
    end

    context 'when the user_id does not exist' do
      it 'returns a 403' do
        post "/users/#{User.current.id + 1}/logout"

        expect(response.status).to eq(403)
        expect(user.session_id).to eq('session_id')
        expect(User.current).to eq(user)
      end
    end
  end
end
