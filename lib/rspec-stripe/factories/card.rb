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
        },
        mastercard: {
          number: "5555555555554444"
        },
        amex: {
          number: "378282246310005"
        },
        discover: {
          number: "6011111111111117"
        },
        diners: {
          number: "30569309025904"
        },
        jcb: {
          number: "3530111333300000"
        }
      }
    end
  end
end
