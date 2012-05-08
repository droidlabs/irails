FactoryGirl.define do
  sequence :email do |n|
    "somebody#{n}@example.com"
  end

  sequence :login do |n|
    "somebody#{n}"
  end

  sequence :stripe_customer_uid do |n|
    "cus_123234234#{n}"
  end
end