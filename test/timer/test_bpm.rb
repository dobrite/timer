require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_nanos_per_beat
      bpm = Bpm.new(120)
      expected = 500_000_000

      assert_equal expected, bpm.nanos_per_beat
    end

    def test_new_prev_beat_at
      stub_now do
        bpm = Bpm.new(120)

        assert_nil bpm.prev_beat_at
      end
    end

    def test_new_next_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        expected = now

        assert_equal expected, bpm.next_beat_at
      end
    end

    def test_update_prev_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        bpm.update(now)

        elapsed_seconds = 0
        nanos = NOW_IN_NANOS + (elapsed_seconds * NANOS_PER_SECOND).floor
        expected = Nanos.from(nanos)

        assert_equal expected, bpm.prev_beat_at
      end
    end

    def test_update_next_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        bpm.update(now)

        elapsed_seconds = 0.5
        nanos = NOW_IN_NANOS + (elapsed_seconds * NANOS_PER_SECOND).floor
        expected = Nanos.from(nanos)

        assert_equal expected, bpm.next_beat_at
      end
    end
  end
end
