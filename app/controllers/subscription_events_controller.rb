class SubscriptionEventsController < ApplicationController
  def stripe
    event = SubscriptionEvent.new(params[:json])
    event.handle
    render nothing: true
  end
end
