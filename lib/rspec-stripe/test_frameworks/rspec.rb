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

            @runner = RSpecStripe::Runner.new(recipes)
            @runner.call!

            def stripe_customer
              @stripe_customer ||= @runner.customer
            end

            def stripe_customer_event
              @stripe_customer_event ||= @runner.customer_event
            end

            def stripe_card_event
              @stripe_card_event ||= @runner.card_event
            end

            def stripe_plan
              @stripe_plan ||= @runner.plan
            end

            def stripe_plan_event
              @stripe_plan_event ||= @runner.plan_event
            end

            def stripe_subscription
              @stripe_subscription ||= @runner.subscription
            end

            def stripe_subscription_event
              @stripe_subscription_event ||= @runner.subscription_event
            end

            def last_stripe_event
              Stripe::Event.all.first
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
