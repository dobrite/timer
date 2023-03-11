# frozen_string_literal: true

require "test_helper"

module Timer
  class TestMilli < Minitest::Test
    def test_now
      assert Milli.now
    end
  end
end
