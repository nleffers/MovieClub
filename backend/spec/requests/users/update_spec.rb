describe 'User API Update Endpoints' do
  let(:user) { create(:user) }
  let(:params) do
    {
      user: {
        username: 'test1',
        password: 'test1',
        email: 'test1@test.com',
        first_name: 'first1',
        last_name: 'last1'
      }
    }
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = user
  end

  describe 'users#update' do
    it 'updates current user successfully' do
      put("/users/#{user.id}", params:)
      json = JSON.parse(response.body)

      user.reload
      expect(json['id']).to eq(user.id)
      expect(json['username']).to eq(user.username)
      expect(json['first_name']).to eq(user.first_name)
      expect(json['last_name']).to eq(user.last_name)
      expect(json['email']).to eq(user.email)
    end
  end
end
