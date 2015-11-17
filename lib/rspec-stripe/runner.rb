module RSpecStripe
  class Runner
    attr_accessor :recipes, :customer, :plan, :subscription, :card

    def initialize(recipes)
      @recipes = recipes
    end

    def call!
      @customer = customer_factory.get if recipes[:customer]
      @plan = plan_factory.get if recipes[:plan]
      @card = card_factory.get if recipes[:card]
      @subscription = subscription_factory.get if recipes[:subscription]
    end

    def cleanup!
      factories.reject(&:nil?).each do |factory|
        begin
          factory.cleanup
        rescue Stripe::InvalidRequestError
        end
      end
    end

    private

    def factories
      [ @subscription_factory, @plan_factory, @card_factory, @customer_factory ]
    end

    def customer_factory
      @customer_factory ||= RSpecStripe::Factory::Customer.new(recipes[:customer])
    end

    def plan_factory
      @plan_factory ||= RSpecStripe::Factory::Plan.new(recipes[:plan])
    end

    def subscription_factory
      raise "No customer given" unless customer
      @subscription_factory ||= RSpecStripe::Factory::Subscription.new(recipes[:subscription], customer)
    end

    def card_factory
      raise "No customer given" unless customer
      @card_factory ||= RSpecStripe::Factory::Card.new(recipes[:card], customer)
    end
  end
end
