require 'rubygems'
require 'stripe'
require 'dotenv'
require 'rspec-stripe'

Dotenv.load

Stripe.api_key = ENV['STRIPE_TEST_KEY']

RSpecStripe.configure do |config|
  config.configure_rspec_metadata!
end
