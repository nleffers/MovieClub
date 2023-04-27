redis_cfg = if ENV['RAILS_ENV'] == 'development'
              {
                url: "redis://#{ENV['REDIS_CACHE_HOST'] || 'localhost'}:#{ENV['REDIS_CACHE_PORT'] || 6379}/0",
              }
            else
              {
                url: "redis://#{ENV['REDIS_CACHE_HOST'] || 'redis'}:#{ENV['REDIS_CACHE_PORT'] || 6380}/0",
                password: "#{ENV['REDIS_PW']}",
                ssl: true
              }
            end
