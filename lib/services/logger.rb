module Services
  module Logger
    extend ActiveSupport::Concern

    silence_warnings do
      Yell::Formatter::PatternRegexp = /([^%]*)(%\d*)?(#{Yell::Formatter::PatternTable.keys.join('|')})?(.*)/m
    end

    included do
      class << self
        def logger
          @logger ||= Yell.new do |l|
            l.adapter :datefile, log_file,
              level: (:debug..:fatal),
              format: Yell.format( "%d [%5L] #%M at %F:%n\n%m\n\n", "%H:%M:%S" ),
              date_pattern: "%Y-week-%V",
              symlink_original_filename: true,
              keep: 4
          end
        end

        def format_message(message)
          case message
            when String
              message
            when Hash
              JSON::pretty_generate message
            else message.inspect
          end
        end

        private
          def log_file
            path = Rails.root.join('log', Rails.env, "#{self.name.underscore}.log")
            FileUtils.mkdir_p File.dirname(path)
            path.to_s
          end
      end

      def logger
        self.class.logger
      end

      def format_message(message)
        self.class.format_message(message)
      end
    end

  end
end