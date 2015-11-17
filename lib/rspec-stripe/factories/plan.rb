module RSpecStripe::Factory
  Plan = Struct.new(:id) do
    def get
      @get ||= begin
        @should_delete = false
        Stripe::Plan.retrieve(id.to_s)
      rescue Stripe::InvalidRequestError
        @should_delete = true
        # Lookup the plan's details and then create it
        Stripe::Plan.create(
          amount: 2000,
          interval: 'month',
          name: 'Amazing Gold Plan',
          currency: 'usd',
          id: id.to_s
        )
      end
    end

    def cleanup
      get.delete if @should_delete
    end
  end
end
