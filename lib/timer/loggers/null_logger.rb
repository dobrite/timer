# frozen_string_literal: true

module Timer
  module Loggers
    class NullLogger
      def log(*)
      end
    end
  end
end
