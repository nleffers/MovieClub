# Application Controller
class ApplicationController < ActionController::API
  before_action :verify_session_id

  def verify_session_id
    session_id = ''
    if request.headers.env['HTTP_X_AUTH_SESSION_ID']
      session_id = request.headers.env['HTTP_X_AUTH_SESSION_ID']
    elsif params['headers']
      session_id = params['headers']['X-AUTH-SESSION-ID']
    end

    render json: {}, status: :unauthorized unless session_verified?(session_id)
  end

  private

  def session_verified?(session_id)
    User.current = User.find_by(session_id:)
    User.current.present?
  end
end
