require 'spec_helper'

Stripe.api_key = ENV['STRIPE_TEST_KEY']

describe 'Basic' do
  it "gives me a customer", stripe: { customer: :new } do
    expect {
      Stripe::Customer.retrieve(stripe_customer.id)
    }.not_to raise_error
  end

  it "gives a plan", stripe: { plan: "test" } do
    expect(stripe_plan).not_to eq(nil)
  end

  it "gives me a subscription", stripe: { customer: :new, plan: "test", subscription: "test" } do
    expect(stripe_customer).not_to eq(nil)
    expect(stripe_plan).not_to eq(nil)
    expect(stripe_subscription).not_to eq(nil)
  end
end
