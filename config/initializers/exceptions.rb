if configatron.exceptions.notify
  Irails::Application.config.middleware.use ExceptionNotifier,
    email_prefix: "[iRails] ",
    sender_address: %{"Notifier" <#{configatron.exceptions.notify_from}>},
    exception_recipients: configatron.exceptions.notify_recipients
end