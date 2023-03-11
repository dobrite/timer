module Timer
  module Loggers
    # Logger to log to STDOUT via puts
    class Logger
      def log(message)
        puts message
      end
    end
  end
end
