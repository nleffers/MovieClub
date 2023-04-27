# Controller to get base configuration info from TheMovieDb API
class StaticInfoController < ApplicationController
  def index
    configuration = TheMovieDb.new.get_api_configuration
    render json: configuration[:body], status: configuration[:code]
  end
end
