module RSpecStripe
  class Runner
    attr_accessor :recipes, :customer, :customer_event,
      :plan, :plan_event, :subscription, :subscription_event,
      :card, :card_event

    def initialize(recipes)
      @recipes = recipes
    end

    def call!
      if recipes[:customer]
        @customer = customer_factory.get
        @customer_event = Stripe::Event.all(type: 'customer.created').first if recipes[:track_events]
      end

      if recipes[:plan]
        @plan = plan_factory.get if recipes[:plan]
        @plan_event = Stripe::Event.all(type: 'plan.created').first if recipes[:track_events]
      end

      if recipes[:card]
        @card = card_factory.get
        @card_event = Stripe::Event.all(type: 'customer.source.created').first if recipes[:track_events]
      end

      if recipes[:subscription]
        @subscription = subscription_factory.get if recipes[:subscription]
        @subscription_event = Stripe::Event.all(type: 'customer.subscription.created').first if recipes[:track_events]
      end
    end

    def cleanup!
      factories.reject(&:nil?).each do |factory|
        factory.cleanup
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
