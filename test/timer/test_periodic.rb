require "test_helper"

module Timer
  class TestPeriodic < Minitest::Test
    include StubNow

    def test_new_next_beat_at
      assert_equal now, periodic.next_beat_at(now)
    end

    private

    def periodic
      bpm = Bpm.new(120)
      bpm.start(now)
      Periodic.new(bpm)
    end

    def now
      Time.new(2023, 1, 1, 12, 0, 0, "UTC").to_i
    end

    def now_in_nanos
      Nanos.new(sec: 1_672_574_400, nsec: 0)
    end
  end
end
