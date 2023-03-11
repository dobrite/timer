module Timer
  module Loggers
    # A noop logger
    class NullLogger
      def log(*)
      end

      def flush
      end
      alias trigger flush

      def append(*)
      end
    end
  end
end
