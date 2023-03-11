# frozen_string_literal: true

require "test_helper"

module Timer
  class TestNanos < Minitest::Test
    def test_now
      assert Nanos.now
    end

    def test_to_millis
      assert Nanos.now.to_millis
    end
  end
end
