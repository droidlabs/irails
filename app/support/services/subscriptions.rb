class Services::Subscriptions
  include Services::Logger

  attr_accessor :errors
  attr_reader :params, :current_user

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def process(action, *args)
    @errors = []
    send(action, *args)
    @errors.empty?
  end

  def update_card_details
    plan = params[:card][:plan]
    if Subscription.free_plan?(plan)
      @errors << "Can't change plan" unless subscription.change_plan(plan)
    elsif card.valid?
      @errors = subscription.change_card(card.stripe_attributes, params[:card][:plan])[:errors]
      card.errors.add(:number, @errors.first)
    else
      @errors << "Card details are invalid"
    end
  end

  def card
    @card ||= Card.new(params[:card])
  end

  def subscription
    @subscription ||= current_user.subscription rescue nil
  end
end
