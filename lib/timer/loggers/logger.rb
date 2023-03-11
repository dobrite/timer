module Timer
  module Loggers
    # Logger to log to STDOUT via puts
    class Logger
      def initialize
        @buffer = []
      end

      def log(message)
        puts message
      end

      def flush
        puts @buffer.join(" ")
        @buffer = []
      end
      alias trigger flush

      def append(message)
        @buffer << message
      end
    end
  end
end
