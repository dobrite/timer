# frozen_string_literal: true

module Timer
  # Milliseconds
  class Millis
    def self.now
      Timer::Nanos.now.to_millis
    end

    def initialize(millis)
      @millis = millis
    end

    private

    attr_reader :millis
  end
end
