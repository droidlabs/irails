class Subscription < ActiveRecord::Base
  DEV_CARD = 'dev_card'
  default_value_for :plan, configatron.subscription.default_plan

  attr_accessible :exp_month, :exp_year, :last_four_digits, :cardholder_name, :card_type

  belongs_to :user

  validates  :plan, inclusion: configatron.subscription.plans, presence: true

  after_create  :create_stripe_customer, if: :use_stripe?
  after_destroy :delete_stripe_customer, if: :use_stripe?

  def use_stripe?
    self.class.stripe_key_present? && !self.class.test_env?
  end

  def card_provided?
    customer_card.present?
  end

  def active_plan
    card_provided? && !blocked? ? plan : 'free'
  end

  def change_plan(plan)
    change_plan!(plan) if plan.to_s != self.plan
  end

  def change_plan!(plan)
    case self.class.plan_change_context(self.plan, plan)
    when :free_to_paid
      update_stripe_subscription_plan(plan)
    when :paid_to_paid
      update_stripe_subscription_plan(plan)
    when :paid_to_free
      delete_stripe_subscription_plan
      unblock!
    when :free_to_free
      unblock!
    end
    self.plan = plan.to_s
    self.save if persisted?
  end

  def should_change_card?
    (blocked? || !card_provided?) && paid_plan?(plan)
  end

  def change_card(attributes, plan = nil)
    if use_stripe?
      response = change_stripe_card!(attributes, plan)
      if response[:errors].blank?
        update_customer(stripe_customer.active_card)
      end
      response
    else
      update_attribute(:customer_card, DEV_CARD)
      update_attribute(:plan, plan) if plan.present?
      {errors: []}
    end
  end

  def update_customer(active_card)
    update_attributes({
      exp_month: active_card.exp_month,
      exp_year: active_card.exp_year,
      last_four_digits: active_card.last4,
      cardholder_name: active_card.name,
      card_type: active_card.type})
  end

  def change_stripe_card!(attributes, plan = nil)
    token = Stripe::Token.create(card: attributes)
    stripe_customer.card = token.id
    stripe_customer.save
    update_attribute(:customer_card, token.id)
    change_plan(plan) if plan.present?
    { errors: [], attributes: attributes, card: token.card }
  rescue Stripe::CardError => e
    { errors: [e.message], attributes: attributes, card: nil }
  end

  def plan?(plan)
    self.active_plan == plan.to_s
  end

  def free_plan?(plan = nil)
    self.class.free_plan?(plan || self.plan)
  end

  def paid_plan?(plan = nil)
    !free_plan?(plan || self.plan)
  end

  def blocked?
    blocked_at.present?
  end

  def block!
    self.blocked_at = Time.now unless free_plan?(plan)
    self.save if persisted?
    delete_stripe_subscription_plan
  end

  def unblock!
    update_attribute(:blocked_at, nil)
  end

  def status
    if free_plan?
      'free'
    elsif blocked?
      'blocked'
    else
      'paid'
    end
  end

  class << self
    def plans
      configatron.subscription.plans || []
    end

    def free_plans
      configatron.subscription.free_plans || []
    end

    def free_plan?(plan)
      free_plans.include?(plan.to_s)
    end

    def plan_change_context(previous_plan, new_plan)
      if free_plan?(previous_plan) && !free_plan?(new_plan)
        :free_to_paid
      elsif !free_plan?(previous_plan) && !free_plan?(new_plan)
        :paid_to_paid
      elsif !free_plan?(previous_plan) && free_plan?(new_plan)
        :paid_to_free
      else
        :free_to_free
      end
    end

    def stripe_key_present?
      configatron.subscription.stripe_key.present?
    end

    def test_env?
      Rails.env.test?
    end
  end

  protected
  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(customer_uid)
  end

  def customer_uid
    read_attribute(:customer_uid) || get_new_customer_uid
  end

  def get_new_customer_uid
    customer = Stripe::Customer.create(
      email: user.email,
      description: "Customer for #{user.email} on #{Rails.env} env"
    )
    update_attribute(:customer_uid, customer.id)
    customer.id
  end

  def create_stripe_customer
    return unless use_stripe?
    get_new_customer_uid
    change_plan!(self.plan)
  end

  def delete_stripe_customer
    stripe_customer.delete if use_stripe?
  end

  def update_stripe_subscription_plan(plan)
    stripe_customer.update_subscription(prorate: true, plan: plan) if use_stripe? && card_provided?
  end

  def delete_stripe_subscription_plan
    if use_stripe?
      stripe_customer.cancel_subscription rescue nil
    end
  end
end