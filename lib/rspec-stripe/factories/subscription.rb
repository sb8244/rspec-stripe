module RSpecStripe::Factory
  Subscription = Struct.new(:id, :customer) do
    def get
      @get ||= begin
        cancel_subscriptions
        customer.subscriptions.create(plan: id)
      end
    end

    def cleanup
      get.delete
    end

    private

    def cancel_subscriptions
      customer.subscriptions.all.each do |sub|
        sub.delete
      end
    end
  end
end
