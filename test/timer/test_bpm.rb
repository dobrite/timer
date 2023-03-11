require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_nanos_per_beat
      now_ns = Nanos.now.value
      bpm = Bpm.new(120, now_ns)
      expected = 500_000_000

      assert_equal expected, bpm.nanos_per_beat
    end
  end
end
