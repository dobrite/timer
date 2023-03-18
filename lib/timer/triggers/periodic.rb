module Timer
  module Triggers
    # Periodic Triggers
    class Periodic
      def initialize(resolution, triggerable, mult: 1)
        @resolution = resolution
        @triggerable = triggerable
        @mult = mult
        @next_mult = nil
        @count = 0
      end

      def trigger
        return unless (@count += 1) == trigger_count

        triggerable.trigger
        @count = 0

        return unless next_mult

        @mult = next_mult
        @next_mult = nil
      end

      def mult=(next_mult)
        @next_mult = next_mult
      end

      private

      def trigger_count
        resolution / mult.to_f
      end

      attr_reader :resolution, :next_mult, :mult, :triggerable
    end
  end
end
