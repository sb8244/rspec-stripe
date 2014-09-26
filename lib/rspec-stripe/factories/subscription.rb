module RSpecStripe::Factory
  Subscription = Struct.new(:id, :customer) do
    attr_accessor :should_delete

    def get
      @should_delete = true
      cancel_subscriptions
      customer.subscriptions.create(plan: id)
    end

    private

    def cancel_subscriptions
      customer.subscriptions.all.each do |sub|
        sub.delete
      end
    end
  end
end
