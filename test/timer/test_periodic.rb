require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_new_prev_beat_at
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns)
        expected = NOW_IN_NANOS

        assert_equal expected, periodic.prev_beat_at
      end
    end

    def test_new_next_beat_at
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns)
        expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor

        assert_equal expected, periodic.next_beat_at
      end
    end

    def test_step_prev_beat_at
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns).tap(&:step)
        expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor

        assert_equal expected, periodic.prev_beat_at
      end
    end

    def test_step_next_beat_at
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns).tap(&:step)
        expected = NOW_IN_NANOS + (1.0 * NANOS_PER_SECOND).floor

        assert_equal expected, periodic.next_beat_at
      end
    end

    def test_new_next_beat_at_mult2
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns, mult: 4)
        expected = NOW_IN_NANOS + (0.125 * NANOS_PER_SECOND).floor

        assert_equal expected, periodic.next_beat_at
      end
    end
  end
end
