FactoryGirl.define do
  factory :subscription do
    customer_uid { generate(:stripe_customer_uid) }
  end

  factory :blocked_subscription, parent: :subscription do
    blocked_at { Time.now }
  end
end