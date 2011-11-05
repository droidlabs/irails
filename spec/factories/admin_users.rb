FactoryGirl.define do
  factory :admin_user do
    email { Factory.next(:email) }
    password "foobar"
    password_confirmation { |u| u.password }  
  end
end