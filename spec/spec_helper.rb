require 'rubygems'
require 'stripe'
require 'dotenv'
require 'rspec-stripe'

Dotenv.load

RSpecStripe.configure do |config|
  config.configure_rspec_metadata!
end
