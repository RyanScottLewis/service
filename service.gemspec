# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "service"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Scott Lewis"]
  s.date = "2012-12-13"
  s.description = "Service encapsulates an object which executes a bit of code in a loop that can be started or stopped and query whether it is running or not."
  s.email = "ryan@rynet.us"
  s.files = ["Gemfile", "LICENSE", "README.md", "Rakefile", "VERSION", "lib/service.rb", "service.gemspec"]
  s.homepage = "http://github.com/RyanScottLewis/service"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A basic implementation of a Service, which has a run loop can be start and stopped or run an a new Thread."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<version>, ["~> 1.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<guard-yard>, ["~> 2.0"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_development_dependency(%q<redcarpet>, ["~> 2.2.2"])
      s.add_development_dependency(%q<github-markup>, ["~> 0.7"])
    else
      s.add_dependency(%q<version>, ["~> 1.0"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<guard-yard>, ["~> 2.0"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_dependency(%q<redcarpet>, ["~> 2.2.2"])
      s.add_dependency(%q<github-markup>, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<version>, ["~> 1.0"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<guard-yard>, ["~> 2.0"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
    s.add_dependency(%q<redcarpet>, ["~> 2.2.2"])
    s.add_dependency(%q<github-markup>, ["~> 0.7"])
  end
end
