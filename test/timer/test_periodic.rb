require "test_helper"

module Timer
  class TestPeriodic < Minitest::Test
    include StubNow

    def test_new_next_beat_at
      stub_now now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        periodic = Periodic.new(bpm)
        expected = now_in_nanos

        assert_equal expected, periodic.next_beat_at(now)
      end
    end

    private

    def now
      Time.new(2023, 1, 1, 12, 0, 0, "UTC").to_i
    end

    def now_in_nanos
      Nanos.new(sec: 1_672_574_400, nsec: 0)
    end
  end
end
