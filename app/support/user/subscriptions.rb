module User::Subscriptions
  extend ActiveSupport::Concern
  
  included do
    has_one :subscription, dependent: :destroy
    before_create :build_subscription
    
    delegate :plan, :plan?, :blocked?, to: :subscription, prefix: true
    
    cattr_accessor :_has_subscription
  end
  
  def build_subscription
    super if subscription.blank?
  end
end