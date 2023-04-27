# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

if Rails.env.development?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'

      resource '*',
        headers: :any,
        methods: %i[get post put delete options]
    end
  end
else
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://immense-mountain-08471.herokuapp.com'

      resource '*',
        headers: :any,
        methods: %i[get post put delete options]
    end
  end

  module Rack
    class Cors
      # resource class
      class Resource
        def to_headers(env)
          h = {
            'Access-Control-Allow-Origin' => origin_for_response_header(env[Rack::Cors::HTTP_ORIGIN]),
            'Access-Control-Allow-Methods' => methods.collect { |m| m.to_s.upcase }.join(', ')
          }
          h['Access-Control-Allow-Credentials'] = true if credentials
          h
        end
      end
    end
  end
end
