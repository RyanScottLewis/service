# Service encapsulates an object which executes a bit of code in a loop that can be started or stopped and query whether
# it is running or not.
class Service

  VERSION = "2.0.0".freeze

  # The instance methods to be mixed into a Service.
  module Base
    
    # The instance methods to be mixed into modules which include/extend Service::Base.
    module InstanceMethods
      
      # Query if the service is currently stopped.
      # 
      # @returns [true, false]
      def stopped?
        @_service_state == :stopped
      end
      
      # Query if the service is currently started.
      # 
      # @returns [true, false]
      def started?
        @_service_state == :started
      end
      alias_method :running?, :started?
      
      # The code that will be executed within the run loop.
      # @abstract Subclass and override {#run} to implement a custom Service.
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
      def stop
        @_service_state = :stopped
      end
      
      # Start the run loop.
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
    
    class << self
      
      # Include Service::Base::InstanceMethods when Service::Base is included.
      def included(base)
        base.send(:include, InstanceMethods)
      end
      
      # Include Service::Base::InstanceMethods when Service::Base is extended.
      def extended(base)
        base.send(:include, InstanceMethods)
      end
      
    end
    
  end
  
  include Base
  
end
