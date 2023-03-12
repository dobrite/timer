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
          nanos_per_unit =
            Nanos.from (bpm.nanos_per_beat * (1 / mult.to_f)).floor
          next_beat_at = bpm.next_beat_at
          next_beat_at += nanos_per_unit while next_beat_at < now
          next_beat_at
        end
    end

    private

    def clear
      @next_beat_at = nil
    end

    attr_reader :bpm, :mult
  end
end
