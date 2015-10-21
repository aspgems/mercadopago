require 'redis/namespace'

Redis.current = Redis::Namespace.new(Chamber.env.app.name, host: Chamber.env.redis.host, port: Chamber.env.redis.port)
Redis.current.select(Chamber.env.redis.database)

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # We're in smart spawning mode.
    Redis.current.client.reconnect if forked
  end
end
