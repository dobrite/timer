require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_new_next_beat_at
      stub_now do
        now = Nanos.now
        bpm = Bpm.new(120, now)
        periodic = Periodic.new(bpm)
        expected = Nanos.from(NOW_IN_NANOS)

        assert_equal expected, periodic.next_beat_at(now)
      end
    end
  end
end
