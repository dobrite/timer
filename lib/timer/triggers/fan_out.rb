module Timer
  module Triggers
    # A trigger that triggers a collection of triggerables
    class FanOut
      def initialize(triggers, final_trigger: Triggers::Noop.new)
        @triggers = triggers
        @final_trigger = final_trigger
      end

      def trigger
        triggers.each(&:trigger)
        final_trigger.trigger
      end

      private

      attr_reader :final_trigger, :triggers
    end
  end
end
