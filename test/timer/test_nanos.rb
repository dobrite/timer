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

    def test_to_f
      stub_now { assert_equal FROZEN_IN_TIME, Nanos.now.to_f }
    end

    def test_from_integer
      actual = Nanos.from(2_000_002_000)
      expected = Nanos.new(sec: 2, nsec: 2000)

      assert_equal expected, actual
    end

    def test_from_nanos
      expected = Nanos.new(sec: 2, nsec: 2000)
      actual = Nanos.from(expected)

      assert_equal expected, actual
    end

    def test_comparable
      now = Nanos.now
      sleep(0.1)
      next_now = Nanos.now

      assert now < next_now
    end

    def test_addition
      one = Nanos.new(sec: 0, nsec: 1)
      two = Nanos.new(sec: 1, nsec: 0)
      expected = Nanos.new(sec: 1, nsec: 1)

      assert_equal expected, (one + two)
    end

    def test_addition_carry
      one = Nanos.new(sec: 0, nsec: 999_999_000)
      two = Nanos.new(sec: 0, nsec: 1000)
      expected = Nanos.new(sec: 1, nsec: 0)

      assert_equal(expected, (one + two))
    end
  end
end
