if configatron.exceptions.notify
  Irails::Application.config.middleware.use ExceptionNotifier,
    email_prefix: "[iRails] ",
    sender_address: %{"Notifier" <#{configatron.exceptions.notify_from}>},
    exception_recipients: configatron.exceptions.notify_recipients

  # Airbrake.configure do |config|
  #   config.api_key = 'WORKMATE_EXCEPTIONS_KEY'
  #   config.host = 'workmateapp.com'
  # end
end