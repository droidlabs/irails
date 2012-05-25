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
configatron.subscription.stripe_key = "Jv5o4XzjVWOxc6QOT401jQ1JIQgpueL4"
configatron.subscription.plans = %w[free paid]
configatron.subscription.free_plans = %w[free]
configatron.subscription.default_plan = 'free'

case Rails.env.to_sym
when :development
  configatron.host = 'localhost:3000'
end