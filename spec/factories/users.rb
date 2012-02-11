FactoryGirl.define do
  factory :user do
    full_name "Bruce Lee"
    email { Factory.next(:email) }
    subscription { |u| u.association(:subscription) }
    password "foobar"
    password_confirmation { |u| u.password }  
  end
  
  factory :confirmed_user, :parent => :user do |u|
    confirmed_at 1.hour.ago
  end
  
  factory :not_confirmed_user, :parent => :user do |u|
    confirmed_at nil
  end
end