# application base
configatron.host = 'example.com'
configatron.noreply = 'noreply@example.com'
configatron.app_name = 'iRails'

# subscriptions
configatron.subscription.stripe_key = nil
configatron.subscription.plans = %w[free paid]
configatron.subscription.default_plan = 'free'

case Rails.env.to_sym
when :development
  configatron.host = 'localhost:3000'
end
  