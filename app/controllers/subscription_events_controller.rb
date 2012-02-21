class SubscriptionEventsController < ApplicationController
  def stripe
    event = SubscriptionEvent.new(params)
    event.handle
    render nothing: true
  end
end
