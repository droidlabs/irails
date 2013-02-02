if defined?(Stripe)
  Stripe.api_key = configatron.subscription.stripe_key
end