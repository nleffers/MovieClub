describe 'User API Show Endpoints' do
  before do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
  end

  describe 'users#show' do
    it 'returns user' do
      user = create(:user)

      get "/users/#{user.id}"

      json = JSON.parse(response.body)
      expect(json['id']).to eq(user.id)
      expect(json['username']).to eq(user.username)
      expect(json['first_name']).to eq(user.first_name)
      expect(json['last_name']).to eq(user.last_name)
      expect(json['email']).to eq(user.email)
    end

    it 'returns user with attachment' do
      user = create(:user, :with_avatar)

      get "/users/#{user.id}"

      json = JSON.parse(response.body)
      expect(json['id']).to eq(user.id)
      expect(json['username']).to eq(user.username)
      expect(json['first_name']).to eq(user.first_name)
      expect(json['last_name']).to eq(user.last_name)
      expect(json['email']).to eq(user.email)
      expect(json['avatar']).not_to eq(nil)
    end
  end
end
