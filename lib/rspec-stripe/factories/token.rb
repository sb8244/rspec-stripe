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
        },
        card_declined: {
          number: "4000000000000341"
        },
        incorrect_number: {
          number: "4242424242424241"
        },
        invalid_expiry_month: {
          number: "4242424242424242",
          exp_month: "13"
        },
        invalid_expiry_year: {
          number: "4242424242424242",
          exp_year: "1970"
        },
        invalid_cvc: {
          number: "4242424242424242",
          cvc: "99"
        }
      }
    end
  end
end
