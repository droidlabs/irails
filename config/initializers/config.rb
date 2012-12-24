# application base
configatron.host = 'example.com'
configatron.noreply = 'noreply@example.com'
configatron.app_name = 'iRails'

# assets
configatron.aws.enabled = false
configatron.aws.bucket = ""
configatron.aws.access_key = ""
configatron.aws.secret_key = ""

# subscriptions
configatron.subscription.enabled = false
configatron.subscription.stripe_key = nil
configatron.subscription.plans = %w[free paid]
configatron.subscription.free_plans = %w[free]
configatron.subscription.default_plan = 'free'

# exception notifier
configatron.exceptions.notify = false
configatron.exceptions.notify_from = 'noreply@example.com'
configatron.exceptions.notify_recipients = %w[noreply@example.com]

case Rails.env.to_sym
when :development
  configatron.host = 'localhost:3000'
when :test
  configatron.subscription.enabled = true
end