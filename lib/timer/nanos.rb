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

    def value
      (sec * NANOS_PER_SECOND) + nsec
    end

    def to_s
      value.to_s
    end

    private

    attr_reader :sec, :nsec
  end
end
