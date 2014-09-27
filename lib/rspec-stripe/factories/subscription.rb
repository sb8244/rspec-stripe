module RSpecStripe::Factory
  Subscription = Struct.new(:id, :customer) do
    def get
      @get ||= begin
        customer.subscriptions.create(plan: id)
      end
    end

    def cleanup
      get.delete
    end
  end
end
