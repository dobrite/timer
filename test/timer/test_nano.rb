# frozen_string_literal: true

require "test_helper"

module Timer
  class TestNano < Minitest::Test
    def test_now
      assert Nano.now
    end

    def test_to_millis
      assert Nano.now.to_millis
    end
  end
end
