RSpec.describe 'Requests from Frontend' do
  let(:session_id) { 'session_id' }
  let(:bad_session_id) { 'bad_session_id' }
  let(:headers) { { 'HTTP_X_AUTH_SESSION_ID' => session_id } }
  let(:bad_headers) { { 'HTTP_X_AUTH_SESSION_ID' => bad_session_id } }

  before do
    User.current = create(:user, session_id:)
  end

  context 'when verifying session id' do
    it 'does not render 401 if session id is verified' do
      get("/users/#{User.current.id}", headers:)

      expect(response.status).to eq(200)
    end

    it 'renders 401 if session id is not verified' do
      get("/users/#{User.current.id}", headers: bad_headers)

      expect(response.status).to eq(401)
    end
  end
end
