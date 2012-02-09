class Subscription < ActiveRecord::Base
  default_value_for :plan, configatron.subscription.default_plan
  
  belongs_to :user
  validates  :plan, presence: true
end