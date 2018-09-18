class Rack::Attack

    # `Rack::Attack` is configured to use the `Rails.cache` value by default,
    # but you can override that by setting the `Rack::Attack.cache.store` value
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    # Always allow requests from localhost
    # (blocklist & throttles are skipped)
    Rack::Attack.safelist('allow from localhost') do |req|
        '127.0.0.1' == req.ip || '::1' == req.ip
    end

    # Throttle all requests by IP (20rpm)
    throttle('req/ip', :limit => 100, :period => 5.minutes) do |req|
        req.ip # unless req.path.start_with?('/assets')
    end

    Rack::Attack.throttled_response = lambda do |env|
        now = Time.now
        match_data = env['rack.attack.match_data']

        headers = {
            'X-RateLimit-Limit' => match_data[:limit].to_s,
            'X-RateLimit-Remaining' => '0',
            'X-RateLimit-Reset' => (now + (match_data[:period] - now.to_i % match_data[:period])).to_s
        }

        [ 429, headers, ["Server Error\n"]]
    end
end