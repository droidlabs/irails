class SubscriptionsController < ApplicationController
  before_filter :init_service, :has_subscription?

  def update
    if @service.process(:update_card_details)
      redirect_to edit_subscription_path, notice: 'Card details were successfully updated'
    else
      flash.now[:alert] = @service.errors.first
      render action: :edit
    end
  end

  private

  def init_service
    @service = Services::Subscriptions.new(current_user, params)
    @card = @service.card
    @subscription = @service.subscription
  end

  def has_subscription?
    redirect_to root_path unless @service.subscription
  end
end