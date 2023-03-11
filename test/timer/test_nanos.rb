# frozen_string_literal: true

require "test_helper"

module Timer
  class TestNanos < Minitest::Test
    include StubNow

    def test_value
      stub_now { assert_equal NOW_IN_NANOS, Nanos.now.value }
    end

    def test_to_s
      stub_now { assert_equal NOW_IN_NANOS.to_s, Nanos.now.to_s }
    end

    def test_to_millis
      assert Nanos.now.to_millis
    end
  end
end
