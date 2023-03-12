module Timer
  # Periodic Timers
  class Periodic
    attr_reader :prev_beat_at, :next_beat_at

    def initialize(bpm, mult: 1)
      @bpm = bpm
      @mult = mult
      @prev_beat_at = bpm.prev_beat_at
      @next_beat_at = calc_next_beat_at
    end

    def update(now, triggerable)
      return unless now >= next_beat_at

      triggerable.trigger
      step
    end

    def step
      @prev_beat_at = next_beat_at
      @next_beat_at = calc_next_beat_at
    end

    private

    def calc_next_beat_at
      prev_beat_at + (bpm.nanos_per_beat * (1 / mult.to_f)).floor
    end

    attr_reader :bpm, :mult
  end
end
