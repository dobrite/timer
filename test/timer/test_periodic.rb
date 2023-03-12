require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    # def test_new_prev_beat_at
    #   stub_now do
    #     now = Nanos.now
    #     bpm = Bpm.new(120, now)
    #     periodic = Periodic.new(bpm)
    #     expected = NOW_IN_NANOS

    #     assert_equal expected, periodic.prev_beat_at
    #   end
    # end

    # def test_new_next_beat_at
    #   stub_now do
    #     now = Nanos.now
    #     bpm = Bpm.new(120, now)
    #     periodic = Periodic.new(bpm)
    #     expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor

    #     assert_equal expected, periodic.next_beat_at
    #   end
    # end

    # def test_step_prev_beat_at
    #   stub_now do
    #     now = Nanos.now
    #     bpm = Bpm.new(120, now)
    #     periodic = Periodic.new(bpm).tap(&:step)
    #     expected = NOW_IN_NANOS + (0.5 * NANOS_PER_SECOND).floor

    #     assert_equal expected, periodic.prev_beat_at
    #   end
    # end

    # def test_step_next_beat_at
    #   stub_now do
    #     now = Nanos.now
    #     bpm = Bpm.new(120, now)
    #     periodic = Periodic.new(bpm).tap(&:step)
    #     expected = NOW_IN_NANOS + (1.0 * NANOS_PER_SECOND).floor

    #     assert_equal expected, periodic.next_beat_at
    #   end
    # end

    # def test_new_next_beat_at_mult2
    #   stub_now do
    #     now = Nanos.now
    #     bpm = Bpm.new(120, now)
    #     periodic = Periodic.new(bpm, mult: 4)
    #     expected = NOW_IN_NANOS + (0.125 * NANOS_PER_SECOND).floor

    #     assert_equal expected, periodic.next_beat_at
    #   end
    # end
  end
end
