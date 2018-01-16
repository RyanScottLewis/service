Gem::Specification.new do |s|
  # Variables
  s.name        = 'service'
  s.author      = 'Ryan Scott Lewis'
  s.email       = 'ryanscottlewis@gmail.com'
  s.summary     = 'A basic implementation of a Service, which has a run loop can be start and stopped or run an a new Thread.'
  s.description = 'Service encapsulates an object which executes a bit of code in a loop that can be started or stopped and query whether it is running or not.'

  # Dependencies
  s.add_development_dependency 'version', '~> 1.0'
  s.add_development_dependency 'rake', '~> 10.0'

  # Pragmatically set variables
  s.homepage      = "http://github.com/RyanScottLewis/#{s.name}"
  s.version       = File.read('VERSION')
  s.require_paths = ['lib']
  s.files         = `git ls-files`.lines.to_a.collect { |s| s.strip }
  s.executables   = `git ls-files -- bin/*`.lines.to_a.collect { |s| File.basename(s.strip) }
end
