# frozen_string_literal: true

module Timer
  # Milliseconds
  class Milli
    def self.now
      Timer::Nano.now.to_millis
    end

    def initialize(millis)
      @millis = millis
    end

    private

    attr_reader :millis
  end
end
