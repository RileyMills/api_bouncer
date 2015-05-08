ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require 'rails/all'
require 'shoulda/matchers'
require "api_bouncer"

RSpec.configure do |config|
  config.order = "random"
  config.mock_with(:rspec) { |c| c.syntax = [:should, :expect] }
  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
end