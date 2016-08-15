module RSpecStripe::Factory
  class Token
    attr_accessor :id

    def initialize(id)
      @id = id || :visa
    end

    def get
      @get ||= begin
        Stripe::Token.create(
          card: {
            exp_month: "01",
            exp_year: "2025",
            cvc: "111"
          }.merge(recipes[id])
        )
      end
    end

    def cleanup
      # no-op
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
