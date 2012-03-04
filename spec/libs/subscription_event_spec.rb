require 'spec_helper'

describe SubscriptionEvent do
  
  before :each do
    if User.respond_to?(:_has_subscription)
      @payed_user = Factory(:user)
      @blocked_user = Factory(:user)
      @blocked_user.subscription.block!
    end
  end
  
  it 'should process successful charge' do
    if User.respond_to?(:_has_subscription)
      paid_until = 5.days.since
      subscription = @blocked_user.subscription
      subscription.should be_blocked
    
      stripe_stub = StripeStub.new
      stripe_event = SubscriptionEvent.new(
        stripe_stub.success_charge(subscription, period_end: paid_until).to_json
      ) 
      stripe_event.handle
      subscription.reload
      subscription.should_not be_blocked
    end
  end
end
