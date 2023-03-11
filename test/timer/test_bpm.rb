# frozen_string_literal: true

require "test_helper"

module Timer
  class TestBpm < Minitest::Test
    include StubNow

    def test_nanos_per_beat
      bpm = Bpm.new(120)
      expected = 500_000_000
      assert_equal expected, bpm.nanos_per_beat
    end
  end
end
