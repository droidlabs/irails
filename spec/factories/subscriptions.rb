FactoryGirl.define do
  factory :subscriptions do
    customer_uid { Factory.next(:stripe_customer_uid) }
  end
end