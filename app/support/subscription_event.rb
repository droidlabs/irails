class SubscriptionEvent
  ATTEMPS_BEFORE_BLOCK = 3
  ATTEMPS_WITH_NOTIFICATION = 1
  EVENTS = %w[invoice_payment_succeeded invoice_payment_failed customer_subscription_trial_will_end
    customer_updated customer_deleted customer_subscription_deleted customer_subscription_updated]

  attr_reader :attributes

  def initialize(json)
    @attributes = json.is_a?(String) ? ActiveSupport::JSON.decode(json) : json
  end

  def subscription
    @subscription ||= Subscription.find_by_customer_uid(stripe_customer_uid)
  end

  def handle
    send(name) if can_be_handled?
  end

  private
  def name
    @name ||= attributes['type'].gsub('.', '_')
  end

  def can_be_handled?
    EVENTS.include?(name) && subscription.present?
  end

  def stripe_event
    @stripe_event ||= Stripe::Event.retrieve(attributes['id'])
  end

  def stripe_customer_uid
    @stripe_customer_uid ||= begin
      stripe_event.data.object.customer
    rescue
      stripe_event.data.object.id
    end
  end

  def invoice_payment_succeeded
    if subscription.blocked? && Time.at(stripe_event.data.object.period_end) > Time.now
      subscription.unblock!
    end
    SubscriptionMailer.payment_succeeded(subscription)
  end

  def invoice_payment_failed
    attemp_count = stripe_event.data.object.attempt_count
    if attemp_count == ATTEMPS_BEFORE_BLOCK && !subscription.blocked?
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

  def customer_updated
    subscription.update_customer(stripe_event.data.object.active_card)
  end

  def customer_deleted
    subscriber = subscription.user
    subscription.delete
    subscriber.create_subscription
  end

  def customer_subscription_deleted
    subscription.block! if Time.at(stripe_event.data.object.ended_at) <= Time.now
  end

  def customer_subscription_updated
    subscription.update_attribute(:plan, stripe_event.data.object.plan.id)
    subscription.unblock! if subscription.blocked?
  end
end