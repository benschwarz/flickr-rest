Gem::Specification.new do |s|
  s.name = "flickr-rest"
  s.version = "0.2"
  s.date = "2008-11-17"
  s.summary = "A light interface to call flickr 'restful' api methods"
  s.email = "ben@germanforblack.com"
  s.homepage = "http://github.com/benschwarz/flickr-rest"
  s.description = "A light interface to call flickr 'restful' api methods"
  s.authors = ["Ben Schwarz"]
  s.files = ["README.markdown", "flickr-rest.gemspec", "lib/flickr-rest.rb"]
  s.require_path = "lib"
  
  # Deps
  s.add_dependency("hpricot", ">= 0.6")
end