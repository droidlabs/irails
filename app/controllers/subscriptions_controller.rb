class SubscriptionsController < ApplicationController
  before_filter :has_subscription?

  def edit

  end

  def update
    if card.valid?
      subscription_response = subscription.change_card(card.stripe_attributes, params[:card][:plan])
      if subscription_response[:errors].any?
        flash.now[:alert] = subscription_response[:errors].first
        render action: :edit
      else
        redirect_to edit_subscription_path, notice: 'Card details were successfully updated'
      end
    else
      flash[:notice] = 'Card details are invalid'
      render :edit
    end
  end

  private

  def card
    @card ||= if params[:card]
      Card.new(params[:card])
    else
      Card.new
    end
  end
  helper_method :card

  def subscription
    @subscription ||= current_user.subscription rescue nil #TODO: check without subs
  end
  helper_method :subscription

  def has_subscription?
    redirect_to root_path unless subscription
  end
end