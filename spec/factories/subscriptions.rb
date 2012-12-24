FactoryGirl.define do
  factory :subscription do
    customer_uid { generate(:stripe_customer_uid) }
  end
end