$:.push File.expand_path("../lib", __FILE__)
require "api_bouncer/version"

Gem::Specification.new do |s|
  s.name        = 'api_bouncer'
  s.version     = ApiBouncerVersion::VERSION
  s.date        = '2015-05-06'
  s.summary     = "Set up configurable API client version requirements."
  s.description = "ApiBouncer allows you to specify GEM-style version requirements for API clients."
  s.authors     = ['Riley Mills']
  s.email       = ['rileypmills@gmail.com']
  s.files       = Dir["{lib}/**/*", "LICENSE"]
  s.homepage    = 'https://github.com/Sarkazein/api_bouncer'
  s.license     = 'MIT'

  s.add_dependency 'rails', '>= 4.0.0'
  s.add_development_dependency 'rspec-rails', '~> 3.2'
  s.add_development_dependency 'shoulda-matchers', '~> 2.8'
end