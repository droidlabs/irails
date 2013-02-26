# application base
configatron.host = 'example.com'
configatron.noreply = 'noreply@example.com'
configatron.app_name = 'iRails'

# assets
configatron.aws.enabled = false
configatron.aws.bucket = ""
configatron.aws.access_key = ""
configatron.aws.secret_key = ""

# background jobs
configatron.background_jobs.namespace = 'iRails'
configatron.background_jobs.auth = true
configatron.background_jobs.username  = 'irails'
configatron.background_jobs.password  = 'irails'

# exception notifier
configatron.exceptions.notify = false
configatron.exceptions.notify_from = 'noreply@example.com'
configatron.exceptions.notify_recipients = %w[noreply@example.com]

case Rails.env.to_sym
when :development
  configatron.host = 'localhost:3000'
  configatron.background_jobs.namespace = false
when :test
end