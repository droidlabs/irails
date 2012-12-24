module Workers
  module ResqueAdapter
    extend ActiveSupport::Concern

    module ClassMethods
      def perform(*args)
        self.new.perform!(*args)
      rescue Exception => e
        handle_exception(e)
      end

      def perform_async(*args)
        Resque.enqueue(self, *args)
      end
    end
  end
end