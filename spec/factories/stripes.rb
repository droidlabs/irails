class StripeStub
  def success_charge(subscription, opts = {})
    p_start = (opts[:period_start] || Time.now).to_i
    p_end = (opts[:period_end] || 1.month.since).to_i
    
    event_object = OpenStruct.new
    event_object.id = 'in_124234234'
    event_object.livemode = true
    event_object.paid = true
    event_object.subtotal = 1000
    event_object.total = 1000
    event_object.period_start = p_start
    event_object.period_end = p_end
    event_object.attempt_count = 0
    event_object.date = Time.now.to_i
    event_object.customer = subscription.customer_uid
    stripe_event('invoice.payment.succeeded', OpenStruct.new(object: event_object))
  end
  
  def stripe_event(type, data)
    response = OpenStruct.new(type: type, data: data)
    Stripe::Event.stub(:retrieve).and_return(response)
    {'type' => type, 'id' => 'evt_234123123'}
  end
end