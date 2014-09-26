module RSpecStripe
  module RSpec
    module Metadata
      extend self

      def configure!
        ::RSpec.configure do |config|
          when_tagged_with_stripe = { stripe: lambda { |val| !!val } }

          config.before(:each, when_tagged_with_stripe) do |ex|
            example = ex.respond_to?(:metadata) ? ex : ex.example
            recipes = example.metadata[:stripe]

            @runner = StripeWorld::Runner.new(recipes)
            @runner.call!

            def stripe_customer
              @stripe_customer ||= @runner.customer
            end

            def stripe_plan
              @stripe_plan ||= @runner.plan
            end

            def stripe_subscription
              @stripe_subscription ||= @runner.subscription
            end
          end

          config.after(:each, when_tagged_with_stripe) do |ex|
            example = ex.respond_to?(:metadata) ? ex : ex.example

            @runner.cleanup!
          end
        end
      end
    end
  end
end
