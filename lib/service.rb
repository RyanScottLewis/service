# Service encapsulates an object which executes a bit of code in a loop that can be started or stopped and query whether
# it is running or not.
class Service

  VERSION = "2.0.0".freeze

  # The instance methods to be mixed into a Service.
  module Base

    # Query if the service is currently stopped.
    #
    # @return [Boolean]
    def stopped?
      @_service_state == :stopped
    end

    # Query if the service is currently started.
    #
    # @return [Boolean]
    def started?
      @_service_state == :started
    end
    alias_method :running?, :started?

    # The code that will be executed within the run loop.
    #
    # @abstract Override {#execute} to implement a custom Service.
    def execute
      raise NotImplementedError
    end

    # Call the {#execute} method within a new Thread.
    #
    # @return [Thread]
    def execute!
      Thread.new { execute }
    end

    # Stop the run loop.
    #
    # @return [Symbol] The current state (`:stopped`).
    def stop
      @_service_state = :stopped
    end

    # Start the run loop.
    #
    # @return [Symbol] The current state (`:started`).
    def start
      @_service_state = :started

      loop do
        break if stopped?

        execute
      end
    end

    alias_method :run, :start

    # Start the run loop in a new Thread.
    #
    # @return [Thread]
    def start!
      Thread.new { start }
    end

    alias_method :run!, :start!

  end

  include Base

end
