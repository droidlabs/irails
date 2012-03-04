class Subscription < ActiveRecord::Base
  default_value_for :plan, configatron.subscription.default_plan

  attr_accessible []

  belongs_to :user

  validates  :plan, presence: true

  after_create  :create_stripe_customer, if: :use_stripe?
  after_destroy :delete_stripe_customer, if: :use_stripe?

  def use_stripe?
    stripe_key_present? && !test_env?
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
    update_attribute(:plan, plan.to_s)
  end

  def should_change_card?
    (blocked? || customer_card.blank?) && paid_plan?(plan)
  end

  def change_card(attributes, plan = nil)
    if use_stripe?
      change_stripe_card!(attributes, plan)
    else
      update_attribute(:customer_card, 'dev_card')
    end
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
    self.plan == plan.to_s
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
    update_attribute(:blocked_at, Time.now)
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
  end

  protected
  def stripe_key_present?
    configatron.subscription.stripe_key.present?
  end

  def test_env?
    Rails.env.test?
  end

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(customer_uid)
  end

  def create_stripe_customer
    return unless use_stripe?
    customer = Stripe::Customer.create(
      email: user.email,
      description: "Customer for #{user.email}"
    )
    update_attribute(:customer_uid, customer.id)
    change_plan!(self.plan)
  end

  def delete_stripe_customer
    stripe_customer.delete if use_stripe?
  end

  def update_stripe_subscription_plan(plan)
    stripe_customer.update_subscription(prorate: true, plan: plan) if use_stripe?
  end

  def delete_stripe_subscription_plan
    stripe_customer.cancel_subscription if use_stripe?
  end
end