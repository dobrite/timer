module Timer
  # Bpm stuffs
  class Bpm
    DEFAULT_RESOLUTION = 24

    attr_reader :resolution

    def initialize(bpm, resolution: DEFAULT_RESOLUTION)
      @bpm = bpm
      @running = false
      @resolution = resolution
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

    def bpm=(new_bpm)
      @bpm = new_bpm
      @next_beat_at = calc_next_beat_at
    end

    private

    def step
      @prev_beat_at = next_beat_at
      @next_beat_at = calc_next_beat_at
    end

    def calc_next_beat_at
      prev_beat_at + nanos_per_beat
    end

    def nanos_per_beat
      (seconds_per_beat * NANOS_PER_SECOND).floor
    end

    def seconds_per_beat
      SECONDS_PER_MINUTE.to_f / bpm / resolution
    end

    attr_reader :bpm, :next_beat_at, :prev_beat_at
  end
end
