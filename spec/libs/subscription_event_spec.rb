require 'spec_helper'

describe SubscriptionEvent do
  let(:user) { FactoryGirl.create(:user) }
  let(:subscription) { user.subscription }

  it 'should not block subscription for free plan' do
    subscription.stubs(:free_plan?).returns(true)
    subscription.block!
    subscription.should_not be_blocked
  end

  describe "successful charge" do
    context "for blocked user" do
      it 'should unblock user' do
        subscription.stubs(:free_plan?).returns(false)
        subscription.block!
        subscription.should be_blocked

        stripe_stub = StripeStub.new
        stripe_event = SubscriptionEvent.new(
          stripe_stub.success_charge(subscription, period_end: 5.days.since).to_json
        )
        stripe_event.handle
        subscription.reload
        subscription.should_not be_blocked
      end
    end
  end
end
