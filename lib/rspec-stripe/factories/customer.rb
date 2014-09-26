module RSpecStripe::Factory
  Customer = Struct.new(:id) do
    def get
      @get ||= begin
        if id == :new || id == true
          @should_delete = true
          Stripe::Customer.create
        else
          @should_delete = false
          Stripe::Customer.retrieve(id)
        end
      end
    end

    def cleanup
      get.delete if @should_delete
    end
  end
end
