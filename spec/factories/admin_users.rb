FactoryGirl.define do
  factory :admin_user do
    email { generate(:email) }
    password "foobar"
    password_confirmation { |u| u.password }
  end
end