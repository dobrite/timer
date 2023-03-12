module Timer
  # Periodic Timers
  class Periodic
    def initialize(bpm, mult: 1)
      @bpm = bpm
      @mult = mult
    end

    def update(now, triggerable)
      return unless now >= next_beat_at(now)

      triggerable.trigger
      clear

      next_beat_at(now)
    end

    def next_beat_at(now)
      @next_beat_at ||=
        begin
          next_beat_at = bpm.next_beat_at
          next_beat_at += nanos_per_unit while next_beat_at < now
          next_beat_at
        end
    end

    private

    def nanos_per_unit
      @nanos_per_unit ||= (bpm.nanos_per_beat * (1 / mult.to_f)).floor
    end

    def clear
      @next_beat_at = nil
      @nanos_per_unit = nil
    end

    attr_reader :bpm, :mult
  end
end
