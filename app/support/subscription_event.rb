class SubscriptionEvent
  ATTEMPS_BEFORE_BLOCK = 3
  ATTEMPS_WITH_NOTIFICATION = 1
  EVENTS = %w[invoice_payment_succeeded invoice_payment_failed customer_subscription_trial_will_end]

  attr_reader :attributes

  def initialize(json)
    @attributes = ActiveSupport::JSON.decode(json)
  end

  def subscription
    @subscription ||= Subscription.find_by_customer_uid(stripe_customer_uid)
  end

  def handle
    send(name) if can_be_handled?
  end

  private
  def name
    @name ||= stripe_event.type.gsub('.', '_')
  end

  def can_be_handled?
    EVENTS.include?(name) && subscription.present?
  end

  def stripe_event
    @stripe_event ||= Stripe::Event.retrieve(attributes['id'])
  end

  def stripe_customer_uid
    @stripe_customer_uid ||= stripe_event.data.object.customer
  end

  def invoice_payment_succeeded
    SubscriptionMailer.payment_succeeded(subscription)
  end

  def invoice_payment_failed
    attemp_count = stripe_event.data.object.attempt_count
    if attemp_count == ATTEMPS_BEFORE_BLOCK
      subscription.block!
      SubscriptionMailer.account_blocked(subscription, attemp_count).deliver
    end
    if attemp_count <= ATTEMPS_WITH_NOTIFICATION
      SubscriptionMailer.payment_failed(subscription, attemp_count).deliver
    end
  end

  def customer_subscription_trial_will_end
    SubscriptionMailer.trial_will_end(subscription).deliver
  end
end
