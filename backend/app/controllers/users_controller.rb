# Controller for Users
class UsersController < ApplicationController
  include Rails.application.routes.url_helpers

  skip_before_action :verify_session_id, only: %i[create login]
  before_action :get_user, only: %i[show update add_to_watchlist remove_from_watchlist upload_avatar]

  def create
    if User.where('username =? OR email = ?', user_params[:username], user_params[:email]).any?
      render status: :conflict
      return
    end

    user = User.create(user_params)
    render status: :unprocessable_entity and return if user.invalid?

    User.current = user
    render_request_token
  end

  def login
    user = User.find_by(username: login_params[:username])
    render status: :not_found and return unless user

    if !user.authenticate(login_params[:password])
      render json: { message: 'Login Rejected' }, status: :unauthorized
      return
    end

    User.current = user
    render json: User.current, status: :ok, serializer: User::LoginSerializer and return if user_authenticated?

    render_request_token
  end

  def logout
    return head :forbidden unless User.current.id == params[:id].to_i

    User.current.update(session_id: nil)
    User.current = nil

    head :ok
  end

  def show
    render json: @user, serializer: User::ShowSerializer
  end

  def update
    @user.update(user_params)

    render json: @user, serializer: User::ShowSerializer
  end

  def add_to_watchlist
    @user.update(movie_watchlist: [*@user.movie_watchlist, watchlist_params.to_json])

    render json: watchlist_params.to_json, status: :ok
  end

  def remove_from_watchlist
    watchlist = @user.movie_watchlist.reject { |movie| JSON.parse(movie)['tmdb_movie_id'] == params[:tmdb_movie_id] }
    @user.update(movie_watchlist: watchlist)

    render status: :ok
  end

  def upload_avatar
    avatar = params[:avatar]
    render status: :bad_request and return unless avatar

    @user.avatar.purge if @user.avatar.attached?
    @user.avatar.attach(io: avatar.open, filename: avatar.original_filename)
    @user.save

    render json: rails_blob_url(@user.avatar), status: :ok
  end

  private

  def user_authenticated?
    User.current.session_id.present?
  end

  def render_request_token
    token_resp = TheMovieDb.new.get_request_token
    User.current.update(token: token_resp[:body]['request_token'])
    render json: token_resp[:body], status: token_resp[:code]
  end

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :username, :password, :email, :first_name, :last_name, :email_notifications, :bio)
  end

  def login_params
    params.require(:login).permit(:username, :password)
  end

  def watchlist_params
    params.permit(:tmdb_movie_id, :movie_title, :movie_poster_path)
  end
end
