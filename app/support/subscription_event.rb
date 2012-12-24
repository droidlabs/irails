class SubscriptionEvent
  include Services::Logger

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

  def invoice
    @invoice ||= Invoice.find_or_create_by_invoice_uid_and_subscription_id(
      stripe_invoice_uid, subscription.id
    )
  end

  def handle
    logger.info "Received event: #{name} for #{user_email}"
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
    @stripe_event ||= Stripe::Event.retrieve(attributes['id']).data.object
  end

  def stripe_invoice_uid
    @stripe_invoice_uid ||= stripe_event.id
  end

  def stripe_customer_uid
    @stripe_customer_uid ||= stripe_event.customer rescue stripe_event.id
  end

  def invoice_payment_succeeded
    if subscription.blocked? && Time.at(stripe_event.period_end) > Time.now
      logger.info "Processing event #{name}: unblock user #{user_email}"
      subscription.unblock!
      logger.info "Processing event #{name}: send unblocked message to #{user_email}"
      SubscriptionMailer.account_unblocked(subscription).deliver
    end
    if stripe_event.total.to_i > 0
      logger.info "Processing event #{name}: send success message to #{user_email}"
      update_invoice_info!(:succeeded)
      SubscriptionMailer.payment_succeeded(invoice).deliver
    end
  end

  def invoice_payment_failed
    attemp_count = stripe_event.attempt_count
    update_invoice_info!(:failed)
    if attemp_count == ATTEMPS_BEFORE_BLOCK && !subscription.blocked?
      logger.info "Processing event #{name}: block user #{user_email}"
      subscription.block!
      logger.info "Processing event #{name}: send blocked message to #{user_email}"
      SubscriptionMailer.account_blocked(subscription).deliver
    end
    if attemp_count <= ATTEMPS_WITH_NOTIFICATION
      logger.info "Processing event #{name}: send failed message to #{user_email}"
      SubscriptionMailer.payment_failed(invoice).deliver
    end
  end

  def update_invoice_info!(status)
    invoice.status = status.to_s
    if status.to_sym == :failed
      invoice.attemp_count = stripe_event.attempt_count
    else
      invoice.billed_at = Time.at(stripe_event.date)
    end
    invoice.amount = stripe_event.total
    invoice.card_number = subscription.number
    invoice.card_type = subscription.card_type
    invoice.stripe_attributes = @attributes
    invoice.charge_uid = stripe_event.charge
    invoice.save!
  end

  def customer_subscription_trial_will_end
    # SubscriptionMailer.trial_will_end(subscription).deliver
  end

  def customer_updated
    subscription.update_customer(stripe_event.active_card)
  end

  def customer_deleted
    subscriber = subscription.user
    subscription.delete
    subscriber.create_subscription
  end

  def customer_subscription_deleted
    subscription.block! if Time.at(stripe_event.ended_at) <= Time.now
  end

  def customer_subscription_updated
    subscription.update_attribute(:plan, stripe_event.plan.id)
    subscription.unblock! if subscription.blocked?
  end

  def user_email
    subscription.try(:user).try(:email)
  end
end