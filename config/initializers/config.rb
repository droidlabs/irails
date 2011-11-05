configatron.host = 'example.com'
configatron.noreply = 'noreply@example.com'
configatron.app_name = 'iRails'

case Rails.env.to_sym
when :development
  configatron.host = 'localhost:3000'
end
  