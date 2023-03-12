require "test_helper"

module Timer
  class TestPeriodic < Minitest::Test
    include StubNow

    def test_new_next_beat_at
      assert_equal now, periodic.next_beat_at(now)
    end

    def test_next_next_beat_at
      new_now = now + Nanos.from(499_999_999)
      periodic.update(new_now, fake_triggerable)
      expected = now + Nanos.from(500_000_000)

      assert_equal expected, periodic.next_beat_at(new_now)
    end

    def test_next_next_next_beat_at
      new_now = now + Nanos.from(500_000_001)
      periodic.update(new_now, fake_triggerable)
      expected = now + Nanos.from(1_000_000_000)

      assert_equal expected, periodic.next_beat_at(new_now)
    end

    private

    def periodic
      bpm = Bpm.new(120)
      bpm.start(now)
      Periodic.new(bpm)
    end

    class FakeTriggerable
      def trigger
      end
    end

    def fake_triggerable
      FakeTriggerable.new
    end

    def now
      # 2023-01-01 12:00:00 UTC
      Nanos.new(sec: 1_672_574_400, nsec: 0)
    end
  end
end
