module Timer
  module Triggers
    # Periodic Triggers
    class Periodic
      attr_writer :mult

      def initialize(mult: 1)
        @mult = mult
        @count = 0
      end

      def update(triggerable)
        return unless (@count += 1) == mult

        triggerable.trigger

        @count = 0
      end

      private

      attr_reader :mult
    end
  end
end
