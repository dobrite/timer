module Timer
  # Periodic Timers
  class Periodic
    attr_reader :prev_beat_at, :next_beat_at

    def initialize(bpm, now_ns)
      @bpm = bpm
      @prev_beat_at = now_ns
      @next_beat_at = prev_beat_at + bpm.nanos_per_beat
    end

    def update(now_ns, triggerable)
      return unless now_ns >= prev_beat_at

      triggerable.trigger
      step
    end

    def step
      @prev_beat_at = next_beat_at
      @next_beat_at = prev_beat_at + bpm.nanos_per_beat
    end

    private

    attr_reader :bpm
  end
end
