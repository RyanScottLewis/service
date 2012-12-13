# Service

__serv·ice__ _noun_ _/ˈsɜr vɪs/_ __:__ The action of helping or doing work for someone.

Service encapsulates an object which executes a bit of code in a loop that can be started or 
stopped and query whether it is running or not.

## Install

### Bundler: `gem 'service'`

### RubyGems: `gem install service`

## Usage

### Defining

You can define an Object as a Service by subclassing `Service` or by including/extending 
`Service::Base`.

```ruby
class ServiceA < Service
end

class ServiceB
  include Service::Base
end

class ServiceC
  extend Service::Base
end
```

A `Service` object stores it's state in the `@_service_state` instance variable as to be as 
unobtrusive as possible when integrating with your custom objects.

The next thing to do is define a `execute` instance method on your object:

```ruby
class MyService < Service
  def execute
    # ...
  end
end
```

### Running

Use the `start`/`run` instance method to call the `execute` instance method in a loop.

```ruby
class MyService < Service
  def execute
    puts "Hello"
  end
end

MyService.new.run
# => Hello
# => Hello
# => ...
```

Use `start!`/`run!` to call the `run` in a new Thread.

```ruby
class MyService < Service
  def execute
    puts "Hello"
  end
end

thread = MyService.new.run!
thread.join
# => Hello
# => Hello
# => ...
```

### Stopping

Use the `stop` instance method break the run loop.  
This will also kill the Thread it is running in, if running in a Thread.

```ruby
class MyService < Service
  def execute
    sleep 3
    stop
  end
end

print "Running MyService in a new Thread... "
thread = MyService.new.run!
thread.join
puts "Done!"
```

### Querying State

Use the `started?`/`running?` or `stopped?` instance methods to determine the current state of 
the Service instance.

```ruby
class MyService < Service
  def execute
    sleep 10
  end
end

service = MyService.new
p service.running? # => false
service.run!
sleep 1
p service.running? # => true
```

## Example

```ruby
require 'service'

class PingService < Service
  def execute
    sleep rand(5)
    print 'ping'
    stop
  end
end

class PongService
  include Service::Base
  
  def execute
    sleep rand(5)
    print 'pong'
    stop
  end
end

class ExcitementService
  extend Service::Base
  
  def execute
    sleep rand(5)
    print '!'
    stop
  end
end

threads = []
threads << PingService.new.run!
threads << PongService.new.run!
threads << ExcitementService.new.run!

threads.each(&:join)
```

## Copyright

Copyright © 2012 Ryan Scott Lewis <ryan@rynet.us>.

The MIT License (MIT) - See LICENSE for further details.

[message_queue]: http://en.wikipedia.org/wiki/Message_queue
[queue]: http://rubydoc.info/stdlib/thread/Queue