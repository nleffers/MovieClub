redis_cfg = {
  host: ENV['REDIS_CACHE_HOST'] || 'localhost',
  port: ENV['REDIS_CACHE_HOST'] || Rails.env.development? ? 6379 : 6380
}

unless Rails.env.development?
  redis_cfg.merge!(
    db: 0,
    password: ENV['REDIS_PW'],
    ssl: true
  )
end

$redis = Redis::Namespace.new('movie_club', redis: Redis.new(redis_cfg))
