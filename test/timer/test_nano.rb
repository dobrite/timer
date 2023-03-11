# frozen_string_literal: true

require "test_helper"

module Timer
  class TestNano < Minitest::Test
    def test_now
      assert Nano.now
    end
  end
end
