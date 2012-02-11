Factory.sequence :email do |n|
  "somebody#{n}@example.com"
end

Factory.sequence :login do |n|
  "somebody#{n}"
end

Factory.sequence :stripe_customer_uid do |n|
  "cus_123234234#{n}"
end