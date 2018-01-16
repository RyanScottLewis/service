spec = eval(File.read('service.gemspec'))

require 'rake/version_task'
Rake::VersionTask.new do |t|
  t.with_git_tag = true
  t.with_gemspec = spec
end

require 'rubygems/package_task'
Gem::PackageTask.new(spec) do |t|
  t.need_zip = false
  t.need_tar = false
end

task :default => :gemspec
