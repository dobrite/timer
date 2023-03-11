# frozen_string_literal: true

module Timer
  # Nanosecond
  class Nanos
    def self.now
      new(sec: Time.now.to_i, nsec: Time.now.nsec)
    end

    def initialize(sec:, nsec:)
      @sec = sec
      @nsec = nsec
    end

    def to_millis
      Timer::Millis.new(nsec / 1_000)
    end

    def to_s
      "#{sec}.#{nsec}"
    end

    private

    attr_reader :sec, :nsec
  end
end
