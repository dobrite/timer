# frozen_string_literal: true

module Timer
  # Bpm stuffs
  class Bpm
    def initialize(bpm)
      @bpm = bpm
    end

    def nanos_per_beat
      (seconds_per_beat * NANOS_PER_SECOND).floor
    end

    private

    def seconds_per_beat
      SECONDS_PER_MINUTE.to_f / bpm
    end

    attr_reader :bpm
  end
end
