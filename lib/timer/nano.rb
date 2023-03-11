# frozen_string_literal: true

module Timer
  # Nanosecond
  class Nano
    def self.now
      new(Time.now.nsec)
    end

    def initialize(nanos)
      @nanos = nanos
    end

    def to_millis
      Timer::Milli.new(nanos / 1_000)
    end

    private

    attr_reader :nanos
  end
end
