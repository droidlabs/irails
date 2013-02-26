FactoryGirl.define do
  sequence :email do |n|
    "somebody#{n}@example.com"
  end

  sequence :login do |n|
    "somebody#{n}"
  end
end