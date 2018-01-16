require 'service'

# Generates the string "ping pong" asynchronously.
# Calls to `sleep 5` simulate computationally intensive work.
#
# Example of using the `#execute!` to execute a service in a new Thread.
# Should take ~5s (instead of ~10s)

class BaseService < Service

  def initialize(buffer)
    @buffer = buffer
  end

end

class PingService < BaseService

  def execute
    sleep 5

    @buffer[0] = 'ping'
  end

end

class PongService < BaseService

  def execute
    sleep 5

    @buffer[1] = 'pong'
  end

end


buffer  = []
threads = []

started_at = Time.now

threads << PingService.new(buffer).execute!
threads << PongService.new(buffer).execute!

threads.each(&:join)

result = buffer.join

puts "Done: '#{result}'"
puts "Took #{Time.now - started_at}s"
