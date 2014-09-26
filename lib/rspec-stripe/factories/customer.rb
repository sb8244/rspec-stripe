module RSpecStripe::Factory
  Customer = Struct.new(:id) do
    attr_accessor :should_delete

    def get
      if id == :new || id == true
        @should_delete = true
        Stripe::Customer.create
      else
        @should_delete = false
        Stripe::Customer.retrieve(id)
      end
    end
  end
end
