module Workers
  module SidekiqAdapter
    extend ActiveSupport::Concern
    include ::Sidekiq::Worker if defined?(Sidekiq)

    def perform(*args)
      perform!(*args)
    rescue Exception => e
      self.class.handle_exception(e)
    end
  end
end