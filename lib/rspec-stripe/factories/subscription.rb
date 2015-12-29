module RSpecStripe::Factory
  Subscription = Struct.new(:id, :customer, :metadata) do
    def get
      @get ||= begin
        customer.subscriptions.create(plan: id, metadata: metadata)
      end
    end

    def cleanup
      get.delete
    end
  end
end
