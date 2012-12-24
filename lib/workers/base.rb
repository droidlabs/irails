# Start any worker with command: Workers::MyWorker.perform_async('test')
class Workers::Base
  include Services::Logger
  include Workers::ResqueAdapter if defined?(Resque)
  include Workers::SidekiqAdapter if defined?(Sidekiq)

  class << self
    def handle_exception(exception)
      if defined?(Airbrake)
        Airbrake.notify_or_ignore(exception)
      else
        logger.error exception.message
      end
    end
  end
end