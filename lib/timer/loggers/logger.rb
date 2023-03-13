module Timer
  module Loggers
    # Logger to log to STDOUT via puts
    class Logger
      def initialize
        clear
      end

      def log(message)
        puts message
      end

      def flush
        puts @buffer
        clear
      end
      alias trigger flush

      def write(index, message)
        @buffer[index * 2] = message
      end

      private

      def clear
        @buffer = " " * 10
      end
    end
  end
end
