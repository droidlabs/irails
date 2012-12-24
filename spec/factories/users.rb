FactoryGirl.define do
  factory :user do
    full_name "Bruce Lee"
    email { generate(:email) }
    subscription { |u| u.association(:subscription) }
    password "foobar"
    password_confirmation { |u| u.password }
  end

  factory :confirmed_user, parent: :user do |u|
    confirmed_at 1.hour.ago
  end

  factory :not_confirmed_user, parent: :user do |u|
    confirmed_at nil
  end

  factory :blocked_user, parent: :user do |u|
    subscription { |u| u.association(:blocked_subscription) }
  end
end