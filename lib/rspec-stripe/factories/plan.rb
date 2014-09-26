module RSpecStripe::Factory
  Plan = Struct.new(:id) do
    attr_accessor :should_delete

    def get
      @should_delete = false
      Stripe::Plan.retrieve(id)
    rescue Stripe::InvalidRequestError
      @should_delete = true
      # Lookup the plan's details and then create it
      Stripe::Plan.create(
        amount: 2000,
        interval: 'month',
        name: 'Amazing Gold Plan',
        currency: 'usd',
        id: id
      )
    end
  end
end
