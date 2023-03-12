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

    def test_comparable
      now = Nanos.now
      sleep(0.1)
      next_now = Nanos.now

      assert now < next_now
    end
  end
end
