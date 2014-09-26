module RSpecStripe::Factory
  class Card
    attr_accessor :id, :customer

    def initialize(id, customer)
      @id = id || :visa
      @customer = customer
    end

    def get
      @get ||= begin
        customer.cards.create(card: recipes[id].merge(
          exp_month: "01",
          exp_year: "2025",
          cvc: "111",
          name: customer.id
        ))
      end
    end

    def cleanup
      get.delete
    end

    def recipes
      {
        visa: {
          number: "4242424242424242"
        }
      }
    end
  end
end
