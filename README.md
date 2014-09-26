rspec-stripe
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

  it "gives me a subscription", stripe: { customer: :new, plan: "test", subscription: "test" } do
    expect(stripe_customer).not_to eq(nil)
    expect(stripe_plan).not_to eq(nil)
    expect(stripe_subscription).not_to eq(nil)
  end
```

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
