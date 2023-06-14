lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'aha-api/version'

Gem::Specification.new do |s|
  s.name        = "aha-api"
  s.version     = AhaApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Waters"]
  s.email       = ["chris@aha.io"]
  s.homepage    = "http://aha.io/"
  s.summary     = "API client for aha.io"
  s.description = ""

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock", ">= 3.18.1"
  s.add_dependency "activesupport"
  s.add_dependency "faraday", ">= 2.0.0"
  s.add_dependency "faraday-follow_redirects"
  s.add_dependency "faraday-mashify"
  s.add_dependency "hashie"
  s.add_dependency "multi_json"
  s.add_dependency "rexml"

  s.files        = Dir.glob("{lib}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end
