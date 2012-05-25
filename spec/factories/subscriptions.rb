FactoryGirl.define do
  factory :subscription do
    customer_uid { Factory.next(:stripe_customer_uid) }
  end
end