# frozen_string_literal: true

require "test_helper"

module Timer
  class TestMillis < Minitest::Test
    def test_now
      assert Millis.now
    end
  end
end
