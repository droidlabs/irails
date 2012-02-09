module User::Subscriptions
  extend ActiveSupport::Concern
  
  included do
    has_one :subscription
    before_create :build_subscription
  end
end