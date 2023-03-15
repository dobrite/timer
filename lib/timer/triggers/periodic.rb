module Timer
  module Triggers
    # Periodic Triggers
    class Periodic
      attr_writer :mult

      def initialize(triggerable, mult: 1)
        @triggerable = triggerable
        @mult = mult
        @count = 0
      end

      def update
        return unless (@count += 1) == mult

        triggerable.trigger

        @count = 0
      end

      private

      attr_reader :mult, :triggerable
    end
  end
end
