RSpec.describe 'TheMovieDb' do
  let(:tmdb) { TheMovieDb.new }

  it 'gets api configuration' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/api_configuration.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_api_configuration

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets request token' do
    allow(Net::HTTP).to receive(:get_response).and_return(
      OpenStruct.new(
        {
          code: 200.to_s,
          body: {
            'success' => true,
            'expires_at' => 2.hours.from_now.strftime('%Y-%m-%d %H:%M:%S %Z'),
            'request_token' => 'fakerequesttoken'
          }.to_json
        }
      )
    )

    resp = tmdb.get_request_token

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets session id' do
    allow_any_instance_of(Net::HTTP).to receive(:request).and_return(
      OpenStruct.new(
        {
          code: 200.to_s,
          body: {
            'session_id' => 'session_id'
          }.to_json
        }
      )
    )

    resp = tmdb.get_session_id('fakerequesttoken')

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets user details' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/get_user_details_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_user_details('fakesessionid')

    expect(resp.keys).to eq(%i[code body])
  end

  it 'search movie query' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/movie_search_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.search('movie', 'batman')

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets trending media' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/trending_media_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_trending_media('movie', 'week')

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets movies' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/popular_movies_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_movies('popular')

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets movie' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    parsed_file[:code] = 200.to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_movie(453_395)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets movie images' do
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow(Net::HTTP).to receive(:get_response).and_return(
      OpenStruct.new(
        {
          code: '200',
          body: movie_response[:images].to_json
        }
      )
    )

    resp = tmdb.get_movie_images(453_395)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets movie videos' do
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow(Net::HTTP).to receive(:get_response).and_return(
      OpenStruct.new(
        {
          code: '200',
          body: movie_response[:videos].to_json
        }
      )
    )

    resp = tmdb.get_movie_videos(453_395)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets movie credits' do
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow(Net::HTTP).to receive(:get_response).and_return(
      OpenStruct.new(
        {
          code: '200',
          body: movie_response[:credits].to_json
        }
      )
    )

    resp = tmdb.get_movie_credits(453_395)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets movie watch providers' do
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow(Net::HTTP).to receive(:get_response).and_return(
      OpenStruct.new(
        {
          code: '200',
          body: movie_response[:watch_providers].to_json
        }
      )
    )

    resp = tmdb.get_movie_watch_providers(453_395)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets similar movies' do
    movie_response = JSON.parse(File.read('spec/fixtures/files/get_movie_response.json')).symbolize_keys
    allow(Net::HTTP).to receive(:get_response).and_return(
      OpenStruct.new(
        {
          code: '200',
          body: movie_response[:similar_movies].to_json
        }
      )
    )

    resp = tmdb.get_movie_similar(453_395)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets person' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/get_person_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_person(37_153)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets person images' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/get_person_images_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_person_images(37_153)

    expect(resp.keys).to eq(%i[code body])
  end

  it 'gets person movie credits' do
    parsed_file = JSON.parse(File.read('spec/fixtures/files/get_person_movie_credits_response.json')).symbolize_keys
    parsed_file[:code] = parsed_file[:code].to_s
    parsed_file[:body] = parsed_file[:body].to_json
    allow(Net::HTTP).to receive(:get_response).and_return(OpenStruct.new(parsed_file))

    resp = tmdb.get_person_movie_credits(37_153)

    expect(resp.keys).to eq(%i[code body])
  end
end
