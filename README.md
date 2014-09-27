rspec-stripe [![Code Climate](https://codeclimate.com/github/sb8244/rspec-stripe/badges/gpa.svg)](https://codeclimate.com/github/sb8244/rspec-stripe) [![Gem Version](https://badge.fury.io/rb/rspec-stripe.svg)](http://badge.fury.io/rb/rspec-stripe)
============

The goal of this project is to easily setup the stripe environment for your tests. In the past, you probably had to create a customer, then a plan, then assign the plan, then create your new plan. That is extremely cumbersome to do once and record. It becomes damn near impossible to recreate that cassette 6 months later when you're refreshing your specs.

With RSpec-Stripe, you can say what you want for your spec, and have it injected into the spec. Like this:

```ruby
  it "gives me a customer", stripe: { customer: :new } do
    expect {
      Stripe::Customer.retrieve(stripe_customer.id)
    }.not_to raise_error

    expect(stripe_plan).to eq(nil)
    expect(stripe_subscription).to eq(nil)
  end

  it "gives a plan", stripe: { plan: "test" } do
    expect(stripe_plan).not_to eq(nil)

    expect(stripe_customer).to eq(nil)
    expect(stripe_subscription).to eq(nil)
  end

  it "gives me a subscription", stripe: { customer: :new, plan: "test", card: :visa, subscription: "test" } do
    expect(stripe_customer).not_to eq(nil)
    expect(stripe_plan).not_to eq(nil)
    expect(stripe_subscription).not_to eq(nil)
  end
```

After the spec, any newly created Stripe objects will be removed. However, if you specify an already existing Stripe object, it will not be removed after the spec.

Installation
============

1. Include `gem 'rspec-stripe'` in your Gemfile
2. `bundle install`
3. In your spec_helper.rb file, include `require 'rspec-stripe'` at the top.
4. Bootstrap it for RSpec:

```
RSpecStripe.configure do |config|
  config.configure_rspec_metadata!
end
```

Options Available
============

There are several options available to include in the stripe hash. The main options are `customer, plan, card, subscription`.

### Customer
For a new customer, use the value `:new` in your hash. New customers will be created and then destroyed just for this spec. This is the recommended use case as rspec-stripe wants to make setup repeatable and easy.

For an existing customer, use the `"cus_something"` Stripe ID in your hash. Existing customers will not be destroyed when the spec is finished.

### Plan
For a new plan, use the value `:new` or any plan id that doesn't exist in your Stripe instance. New plans will be created and then destroyed just for this spec. This is the recommended use case. Currently, you cannot specify the plan details and a default is used. This will be expanded on in upcoming versions.

For an existing plan, use the `"plan_id"` Stripe Plan ID in your hash. Existing plans will not be destroyed when the spec is finished.

### Card
Cards are always created new when specified. There are several different built-in card types given from the Stripe Docs. These card names are `:visa :mastercard :amex :discover :diners :jcb :card_declined :incorrect_number :invalid_expiry_month :invalid_expiry_year :invalid_cvc`. You can pass any of these card names for the card hash value and that card will be created as a default for the current customer and then delete it when done with the spec.

Card requires that `customer` is defined and will raise an exception if the customer is not given (either new or existing is fine).

### Subscription
Subscriptions are always created new when specified. Use the value `"plan_id"` for the subscription field. The subscription will be created with this plan and then deleted after the spec.

Subscription requires that `customer` is defined and will raise an exception if the customer is not given (either new or existing is fine).
