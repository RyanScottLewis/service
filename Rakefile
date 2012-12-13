require 'pathname'

def require_task(path)
  begin
    require path
    
    yield
  rescue LoadError
    puts '', "Could not load '#{path}'.", 'Try to `rake gem:spec` and `bundle install` and try again.', ''
  end
end

spec = Gem::Specification.new do |s|
  
  # Variables
  s.name = 'service'
  s.author = 'Ryan Scott Lewis'
  s.email = 'ryan@rynet.us'
  s.summary = 'A basic implementation of a Service, which has a run loop can be start and stopped or run an a new Thread.'
  s.description = 'Service encapsulates an object which executes a bit of code in a loop that can be started or stopped and query whether it is running or not.'
  
  # Dependencies
  s.add_dependency 'version', '~> 1.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'guard-yard', '~> 2.0'
  s.add_development_dependency 'rb-fsevent', '~> 0.9'
  s.add_development_dependency 'redcarpet', '~> 2.2.2'
  s.add_development_dependency 'github-markup', '~> 0.7'
  
  # Pragmatically set variables
  s.homepage = "http://github.com/RyanScottLewis/#{s.name}"
  s.version = Pathname.glob('VERSION*').first.read
  s.require_paths = ['lib']
  s.files        = `git ls-files`.lines.to_a.collect { |s| s.strip }
  s.executables  = `git ls-files -- bin/*`.lines.to_a.collect { |s| File.basename(s.strip) }
  
end

desc 'Generate the gemspec defined in this Rakefile'
task :gemspec do
  Pathname.new("#{spec.name}.gemspec").open('w') { |f| f.write(spec.to_ruby) }
end

require_task 'rake/version_task' do
  Rake::VersionTask.new do |t|
    t.with_git_tag = true
    t.with_gemspec = spec
  end
end

require 'rubygems/package_task'
Gem::PackageTask.new(spec) do |t|
  t.need_zip = false
  t.need_tar = false
end

task :default => :gemspec
