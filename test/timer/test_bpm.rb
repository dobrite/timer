require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_nanos_per_beat_resolution4
      bpm = Bpm.new(120, resolution: 4)
      expected = 500_000_000 / bpm.resolution

      assert_equal expected, bpm.send(:nanos_per_beat)
    end

    def test_nanos_per_beat_resolution24
      bpm = Bpm.new(120)
      expected = 500_000_000 / bpm.resolution

      assert_equal expected, bpm.send(:nanos_per_beat)
    end

    def test_new_prev_beat_at
      stub_now do
        bpm = Bpm.new(120)

        assert_nil bpm.send(:prev_beat_at)
      end
    end

    def test_new_next_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        expected = now

        assert_equal expected, bpm.send(:next_beat_at)
      end
    end

    def test_update_prev_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        bpm.update(now)

        elapsed_seconds = 0
        expected = NOW_IN_NANOS + (elapsed_seconds * NANOS_PER_SECOND).floor

        assert_equal expected, bpm.send(:prev_beat_at)
      end
    end

    def test_update_next_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120)
        bpm.start(now)
        bpm.update(now)

        elapsed_seconds = 0.5 / bpm.resolution.to_f
        expected = NOW_IN_NANOS + (elapsed_seconds * NANOS_PER_SECOND).floor

        assert_equal expected, bpm.send(:next_beat_at)
      end
    end
  end
end
