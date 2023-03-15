module Timer
  module Triggers
    # A trigger that triggers a collection of triggerables
    class FanOut
      def initialize(triggers)
        @triggers = triggers
      end

      def trigger
        triggers.each(&:trigger)
      end

      private

      attr_reader :triggers
    end
  end
end
