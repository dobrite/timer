# frozen_string_literal: true

module Timer
  # Periodic Timers
  class Periodic
    attr_reader :curr_beat_nanos, :next_beat_nanos

    def initialize(bpm, now_ns)
      @bpm = bpm
      @curr_beat_nanos = now_ns
      @next_beat_nanos = curr_beat_nanos + bpm.nanos_per_beat
    end

    def update(now_ns)
      step if now_ns >= curr_beat_nanos
    end

    def step
      @curr_beat_nanos = next_beat_nanos
      @next_beat_nanos = curr_beat_nanos + bpm.nanos_per_beat
    end

    private

    attr_reader :bpm
  end
end
