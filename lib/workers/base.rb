# Start any worker with command: Workers::MyWorker.perform_async('test')
require 'has_active_logger'
class Workers::Base
  extend ActiveSupport::Concern
  include HasActiveLogger::Mixin
  include ::Sidekiq::Worker if defined?(Sidekiq)

  def perform(*args)
    perform!(*args)
  rescue Exception => e
    self.class.handle_exception(e)
  end

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