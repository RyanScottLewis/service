# Service

Service encapsulates an object which executes a bit of code in a loop that can be started or stopped and query whether
it is running or not.

## Install

### Bundler: `gem 'service'`

### RubyGems: `gem install service`

## Usage

> See the `examples/` directory for more usage examples.

### Requiring

  Class/Module   | File
-----------------|--------------------------
 `Service`       | `service`
 `Service::Base` | `service/base`

### Defining

You can define an Object as a Service by subclassing `Service` or by including `Service::Base`:

```ruby
class ServiceA < Service
end

class ServiceB

  include Service::Base

end
```

> A `Service` object stores it's state in the `@_service_state` instance variable as to be as unobtrusive as possible
> when integrating with your custom objects.

The next thing to do is to define an `#execute` instance method on your object:

```ruby
class MyService < Service

  def execute
    # ...
  end

end
```

### Running

Service simply allows you to run your code that is within the `#execute` instance method in four different ways:

* Once (`#execute`)
* Once, within a new Thread (`#execute!`)
* Looping (`#start`/`#run`)
* Looping, within a new Thread (`#start!`/`#run!`)

***

Use the `#start`/`#run` instance method to call the `#execute` instance method in a loop.

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

Use `#start!`/`#run!` to call the `#execute` instance method in a new Thread.

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

Use the `#stop` instance method break the run loop.  
This will also kill the Thread it is running in, if running within a Thread.

```ruby
class CountingService < Service

  def initialize
    @count = 0
  end

  def execute
    puts @count
    sleep 1

    @count += 1
  end

end

service = CountingService.new

service.run! # Run the #execute method in a loop within a new Thread
sleep 5
service.stop
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

## Copyright

Copyright © 2012 Ryan Scott Lewis <ryanscottlewis@gmail.com>.

The MIT License (MIT) - See LICENSE for further details.
