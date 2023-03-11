# frozen_string_literal: true

module Timer
  # Bpm stuffs
  class Bpm
    attr_reader :curr_beat_nanos, :next_beat_nanos

    def initialize(bpm, now_ns)
      @bpm = bpm
      @curr_beat_nanos = now_ns
      @next_beat_nanos = curr_beat_nanos + nanos_per_beat
    end

    def update(now_ns)
      step if now_ns >= curr_beat_nanos
    end

    def step
      @curr_beat_nanos = next_beat_nanos
      @next_beat_nanos = curr_beat_nanos + nanos_per_beat
    end

    private

    def nanos_per_beat
      (seconds_per_beat * NANOS_PER_SECOND).floor
    end

    def seconds_per_beat
      SECONDS_PER_MINUTE.to_f / bpm
    end

    attr_reader :bpm
  end
end
