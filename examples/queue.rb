require 'service'
# require 'thread' # For the Queue class

# Running two services which transfer data to each other in a thread-safe manner.
#
# Example of using the `#run!` to execute a service's run loop in a new Thread.

class BaseService < Service

  def initialize(queue)
    @queue = queue
  end

end

# A service which counts infinitely, adding each number to the queue.
class CountService < BaseService

  def initialize(queue)
    super

    @count = 0
  end

  def execute
    sleep rand(2)    # Simulate computationally intensive work
    @queue << @count # Add the current count to the queue
    @count += 1      # Increment the count
  end

end

# A service which pops all values off each value and prints it each cycle
class ReportService < BaseService

  def execute
    sleep 1                              # Wait for a bit, to allow the queue to populate
    puts(@queue.pop) until @queue.empty? # Until the queue is empty, pop a value off the queue and print it
  end

end

threads = []
queue   = Queue.new

threads << CountService.new(queue).run!
threads << ReportService.new(queue).run!

threads.each(&:join)
