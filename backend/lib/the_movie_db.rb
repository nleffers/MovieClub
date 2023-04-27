# Handles calls to TheMovieDatabase API
class TheMovieDb
  def initialize
    @secure_base_url = 'https://api.themoviedb.org/3/'
    @api_key = YML_VAR['tmdb_api_key_v3']
  end

  def get_api_configuration
    resp = send_get_request('configuration')
    parse_results(resp)
  end

  def get_request_token
    resp = send_get_request('authentication/token/new')
    parse_results(resp)
  end

  def get_session_id(token)
    resp = send_post_request('authentication/session/new', { request_token: token })
    parse_results(resp)
  end

  def get_user_details(session_id)
    resp = send_get_request('account', session_id:)
    parse_results(resp)
  end

  # on frontend, don't send request if query is empty
  def search(search_type, query)
    resp = send_get_request("search/#{search_type}", query:)
    parse_results(resp)
  end

  def get_trending_media(media_type, time_window)
    resp = send_get_request("trending/#{media_type}/#{time_window}")
    parse_results(resp)
  end

  # upcoming, now playing, top rated, popular
  def get_movies(query_type)
    resp = send_get_request("movie/#{query_type}")
    parse_results(resp)
  end

  def get_movie(movie_id)
    resp = send_get_request("movie/#{movie_id}")
    parse_results(resp)
  end

  def get_movie_images(movie_id)
    resp = send_get_request("movie/#{movie_id}/images")
    parse_results(resp)
  end

  def get_movie_videos(movie_id)
    resp = send_get_request("movie/#{movie_id}/videos")
    parse_results(resp)
  end

  def get_movie_credits(movie_id)
    resp = send_get_request("movie/#{movie_id}/credits")
    parse_results(resp)
  end

  def get_movie_watch_providers(movie_id)
    resp = send_get_request("movie/#{movie_id}/watch/providers")
    parse_results(resp)
  end

  def get_movie_similar(movie_id)
    resp = send_get_request("movie/#{movie_id}/similar")
    parse_results(resp)
  end

  def get_person(person_id)
    resp = send_get_request("person/#{person_id}")
    parse_results(resp)
  end

  def get_person_images(person_id)
    resp = send_get_request("person/#{person_id}/images")
    parse_results(resp)
  end

  def get_person_movie_credits(person_id)
    resp = send_get_request("person/#{person_id}/movie_credits")
    parse_results(resp)
  end

  private

  def send_get_request(path, params = {})
    get_params = { **params, api_key: @api_key }
    uri = URI("#{@secure_base_url}#{path}")
    uri.query = URI.encode_www_form(get_params)
    Net::HTTP.get_response(uri)
  end

  def send_post_request(path, params)
    uri = URI("#{@secure_base_url}#{path}?api_key=#{@api_key}")

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/json'
    req.body = params.to_json

    https.request(req)
  end

  def parse_results(resp)
    code = JSON.parse(resp.code)
    body = JSON.parse(resp.body)

    Rails.logger.error("#{code}: #{body['status_message']}") unless code == 200
    { code:, body: }
  end
end
