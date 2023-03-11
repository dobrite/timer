# frozen_string_literal: true

require "test_helper"

module Timer
  class TestNanos < Minitest::Test
    include StubNow

    def test_to_s
      stub_now do
        expected = "#{Time.now.to_i}.#{Time.now.nsec}"
        assert_equal expected, Nanos.now.to_s
      end
    end

    def test_to_millis
      assert Nanos.now.to_millis
    end
  end
end
