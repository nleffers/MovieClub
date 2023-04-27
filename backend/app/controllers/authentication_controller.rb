# Controller for Authentication
class AuthenticationController < ApplicationController
  skip_before_action :verify_session_id
  before_action :initialize_tmdb

  def post_session_id
    User.current = User.find_by(token: auth_params[:request_token])

    resp = @tmdb.get_session_id(auth_params[:request_token])
    set_user_auth_info(resp[:body], resp[:code])

    render json: User.current, status: :ok, serializer: User::LoginSerializer and return if resp[:code] == 200

    render json: resp[:body], status: resp[:code]
  end

  private

  def initialize_tmdb
    @tmdb = TheMovieDb.new
  end

  def set_user_auth_info(body, code)
    return unless code == 200

    User.current.assign_attributes(session_id: body['session_id'], token: nil)
    User.current.assign_attributes(tmdb_id: @tmdb.get_user_details(body['session_id'])[:body]['id']) if User.current.tmdb_id.nil?

    User.current.save
  end

  def auth_params
    params.permit(:request_token)
  end
end
