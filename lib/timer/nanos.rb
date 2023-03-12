module Timer
  # Nanosecond
  class Nanos
    include Comparable

    class << self
      def now
        new(sec: Time.now.to_i, nsec: Time.now.nsec)
      end

      def from(nsec)
        case nsec
        when Integer
          new(sec: nsec / NANOS_PER_SECOND, nsec: nsec % NANOS_PER_SECOND)
        when Nanos
          nsec
        else
          raise "do not know how to create Nanos from #{other.class}"
        end
      end
    end

    def initialize(sec:, nsec:)
      @sec = sec
      @nsec = nsec
    end

    def value
      (sec * NANOS_PER_SECOND) + nsec
    end

    def to_f
      value / NANOS_PER_SECOND.to_f
    end

    def to_s
      value.to_s
    end

    def <=>(other)
      value <=> other.value
    end

    def +(other)
      nano = Nanos.from(other)
      nsecs = nsec + nano.nsec
      carry = nsecs / NANOS_PER_SECOND

      Nanos.new(sec: sec + nano.sec + carry, nsec: nsecs % NANOS_PER_SECOND)
    end

    protected

    attr_accessor :sec, :nsec
  end
end
