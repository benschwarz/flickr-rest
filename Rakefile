require 'lib/flickr-rest'
require "rake/clean"
require "rake/gempackagetask"

spec = Gem::Specification.new do |s| 
  s.name = "flickr-rest"
  s.version = Flickr::Query::VERSION
  s.author = "Ben Schwarz"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://germanforblack.com/"
  s.platform = Gem::Platform::RUBY
  s.summary = "A light interface to call flickr 'restful' api methods"
  s.description = s.summary
  s.files = %w(README Rakefile lib/flickr-rest.rb)
  s.add_dependency("hpricot", ">= 0.6")
  s.has_rdoc = true
end

Rake::GemPackageTask.new(spec) do |package|
  package.gem_spec = spec
end

# Windows install support
windows = (PLATFORM =~ /win32|cygwin/) rescue nil
SUDO = windows ? "" : "sudo"

desc "Install flickr-rest"
task :install => [:package] do
  sh %{#{SUDO} gem install --local pkg/flickr-rest-#{Flickr::Query::VERSION}.gem}
end