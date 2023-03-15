module Timer
  module Triggers
    # Periodic Triggers
    class Periodic
      attr_writer :mult

      def initialize(resolution, triggerable, mult: 1)
        @resolution = resolution
        @triggerable = triggerable
        @mult = mult
        @count = 0
      end

      def trigger
        return unless (@count += 1) == trigger_count

        triggerable.trigger

        @count = 0
      end

      private

      def trigger_count
        resolution / mult.to_f
      end

      attr_reader :resolution, :mult, :triggerable
    end
  end
end
