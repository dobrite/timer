require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_new_curr_beat_nanos
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns)

        expected = NOW_IN_NANOS
        assert_equal expected, periodic.curr_beat_nanos
      end
    end

    def test_new_next_beat_nanos
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns)

        expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor
        assert_equal expected, periodic.next_beat_nanos
      end
    end

    def test_step_curr_beat_nanos
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns).tap(&:step)

        expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor
        assert_equal expected, periodic.curr_beat_nanos
      end
    end

    def test_step_next_beat_nanos
      stub_now do
        now_ns = Nanos.now.value
        bpm = Bpm.new(120)
        periodic = Periodic.new(bpm, now_ns).tap(&:step)

        expected = NOW_IN_NANOS + (1.0 * NANOS_PER_SECOND).floor
        assert_equal expected, periodic.next_beat_nanos
      end
    end
  end
end
