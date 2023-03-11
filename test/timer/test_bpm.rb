# frozen_string_literal: true

require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_new_curr_beat_nanos
      stub_now { assert_equal NOW_IN_NANOS, Bpm.new(120).curr_beat_nanos }
    end

    def test_new_next_beat_nanos
      stub_now do
        expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor
        assert_equal expected, Bpm.new(120).next_beat_nanos
      end
    end

    def test_step_curr_beat_nanos
      stub_now do
        bpm = Bpm.new(120).tap(&:step)
        expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor
        assert_equal expected, bpm.curr_beat_nanos
      end
    end

    def test_step_next_beat_nanos
      stub_now do
        bpm = Bpm.new(120).tap(&:step)
        expected = NOW_IN_NANOS + (1.0 * NANOS_PER_SECOND).floor
        assert_equal expected, bpm.next_beat_nanos
      end
    end
  end
end
