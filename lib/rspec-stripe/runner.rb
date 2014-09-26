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

      if recipes[:subscription]
        @card ||= card_factory.get
        @subscription = subscription_factory.get
      end
    end

    def cleanup!
      subscription.delete if subscription_factory.should_delete
      plan.delete if plan_factory.should_delete
      card.delete if card_factory.should_delete
      customer.delete if customer_factory.should_delete
    end

    private

    def customer_factory
      @customer_factory ||= RSpecStripe::Factory::Customer.new(recipes[:customer])
    end

    def plan_factory
      @plan_factory ||= RSpecStripe::Factory::Plan.new(recipes[:plan])
    end

    def subscription_factory
      @subscription_factory ||= RSpecStripe::Factory::Subscription.new(recipes[:subscription], customer)
    end

    def card_factory
      @card_factory ||= RSpecStripe::Factory::Card.new(recipes[:card], customer)
    end
  end
end
