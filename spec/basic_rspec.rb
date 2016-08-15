require 'spec_helper'

describe 'Basic' do
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

  it "gives me a token", stripe: { token: :visa } do
    expect(stripe_token).not_to eq(nil)
  end
end
