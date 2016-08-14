require 'rspec-stripe/configuration'
require 'rspec-stripe/runner'
require 'rspec-stripe/factories/customer'
require 'rspec-stripe/factories/plan'
require 'rspec-stripe/factories/subscription'
require 'rspec-stripe/factories/card'
require 'rspec-stripe/factories/token'

module RSpecStripe
  extend self

  module RSpec
    autoload :Metadata, "rspec-stripe/test_frameworks/rspec"
  end

  def configure
    yield configuration
  end

  def configuration
    @configuration ||= Configuration.new
  end
end
