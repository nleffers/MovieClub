describe 'User Upload Avatar Endpoints' do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:session_verified?).and_return(true)
    User.current = user
  end

  describe 'users#upload_avatar' do
    it 'uploads an avatar to user' do
      include ActionDispatch::TestProcess::FixtureFile
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/asu-256.png'), 'image/png')
      params = { avatar: file }

      expect(user.avatar.attached?).to eq(false)

      put("/users/#{user.id}/upload_avatar", params:)

      user.reload
      expect(user.avatar.attached?).to eq(true)
    end
  end
end
