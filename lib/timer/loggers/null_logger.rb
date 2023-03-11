module Timer
  module Loggers
    # A noop logger
    class NullLogger
      def log(*)
      end
    end
  end
end
