module Timer
  # Bpm stuffs
  class Bpm
    attr_reader :prev_beat_at, :next_beat_at

    def initialize(bpm, now_ns)
      @bpm = bpm
      @prev_beat_at = nil
      @next_beat_at = now_ns
    end

    def update(now_ns, triggerable)
      return unless now_ns >= next_beat_at

      triggerable.log("!")
      step
    end

    def step
      @prev_beat_at = next_beat_at
      @next_beat_at = calc_next_beat_at
    end

    def nanos_per_beat
      (seconds_per_beat * NANOS_PER_SECOND).floor
    end

    private

    def calc_next_beat_at
      prev_beat_at + nanos_per_beat
    end

    def seconds_per_beat
      SECONDS_PER_MINUTE.to_f / bpm
    end

    attr_reader :bpm
  end
end
