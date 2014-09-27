require 'spec_helper'
require 'fakeweb'

# Only calls that we stub out can work, giving confidence that our tests are only
# making the calls that we want
FakeWeb.allow_net_connect = false

describe RSpecStripe::Runner do
  describe "customer" do
    let(:customer_double) { double(Stripe::Customer) }

    context "with a new customer" do
      before(:each) {
        expect(Stripe::Customer).to receive(:create).once { customer_double }
      }

      it "creates a customer" do
        runner = RSpecStripe::Runner.new({customer: :new})
        runner.call!
      end

      it "cleans up the customer" do
        expect(customer_double).to receive(:delete).once
        runner = RSpecStripe::Runner.new({customer: :new})
        runner.call!
        runner.cleanup!
      end
    end

    context "with an existing customer" do
      before(:each) {
        expect(Stripe::Customer).to receive(:retrieve).once { customer_double }
      }

      it "doesn't create a customer" do
        runner = RSpecStripe::Runner.new({customer: "id"})
        runner.call!
      end

      it "doesn't clean up a customer" do
        runner = RSpecStripe::Runner.new({customer: "id"})
        runner.call!
        runner.cleanup!
      end
    end
  end

  describe "plan" do
    let(:plan_double) { double(Stripe::Plan) }

    context "with a new plan" do
      before(:each) {
        expect(Stripe::Plan).to receive(:retrieve).once { raise Stripe::InvalidRequestError.new("", "", 404) }
        expect(Stripe::Plan).to receive(:create).once.with(hash_including(name: "Amazing Gold Plan")) { plan_double }
      }

      it "creates the plan" do
        runner = RSpecStripe::Runner.new({plan: "test"})
        runner.call!
      end

      it "cleans up" do
        expect(plan_double).to receive(:delete).once
        runner = RSpecStripe::Runner.new({plan: "test"})
        runner.call!
        runner.cleanup!
      end

      it "can create plans based on recipes"
    end

    context "with an existing plan" do
      before(:each) {
        expect(Stripe::Plan).to receive(:retrieve).once { plan_double }
      }

      it "retrieves the plan" do
        runner = RSpecStripe::Runner.new({plan: "test"})
        runner.call!
      end

      it "doesn't clean up" do
        runner = RSpecStripe::Runner.new({plan: "test"})
        runner.call!
        runner.cleanup!
      end
    end
  end
end
