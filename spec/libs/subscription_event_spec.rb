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
      let(:user) { FactoryGirl.create(:blocked_user) }

      before :each do
        stripe_stub = StripeStub.new
        @stripe_event = SubscriptionEvent.new(
          stripe_stub.success_charge(subscription, period_end: 5.days.since)
        )
        @stripe_event.subscription.stubs(:free_plan?).returns(false)
      end

      it 'should unblock user' do
        @stripe_event.handle
        subscription.reload
        subscription.should_not be_blocked
      end

      it 'should notify about unblocking' do
        SubscriptionMailer.account_unblocked(subscription).should deliver_to(user.email)
        @stripe_event.handle
      end
    end
  end

  describe "failed charge" do
    context "for active user on third attemp" do
      let(:user) { FactoryGirl.create(:user) }

      before :each do

        stripe_stub = StripeStub.new
        @stripe_event = SubscriptionEvent.new(
          stripe_stub.failed_charge(subscription, period_end: 5.days.since, attempt_count: 3)
        )
        @stripe_event.subscription.stubs(:free_plan?).returns(false)
      end

      it 'should block user' do
        @stripe_event.handle
        subscription.reload
        subscription.should be_blocked
      end

      it 'should notify about blocking' do
        SubscriptionMailer.account_blocked(subscription).should deliver_to(user.email)
        @stripe_event.handle
      end
    end
  end
end
