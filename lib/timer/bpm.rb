module Timer
  # Bpm stuffs
  class Bpm
    attr_reader :next_beat_at, :prev_beat_at

    def initialize(bpm)
      @bpm = bpm
      @running = false
    end

    def start(now)
      @next_beat_at = now
      @prev_beat_at = now - nanos_per_beat
      @running = true
    end

    def running?
      @running
    end

    def update(now, triggerable: Triggers::Noop.new)
      return if now < next_beat_at

      triggerable.trigger

      step
    end

    def nanos_per_beat
      (seconds_per_beat * NANOS_PER_SECOND).floor
    end

    def bpm=(new_bpm)
      @bpm = new_bpm
      @next_beat_at = calc_next_beat_at
    end

    def resolution
      24
    end

    private

    def step
      @prev_beat_at = next_beat_at
      @next_beat_at = calc_next_beat_at
    end

    def calc_next_beat_at
      prev_beat_at + nanos_per_beat
    end

    def seconds_per_beat
      SECONDS_PER_MINUTE.to_f / bpm / resolution
    end

    attr_reader :bpm
  end
end
