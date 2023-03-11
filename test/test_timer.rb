# frozen_string_literal: true

require "test_helper"

class TestTimer < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Timer::VERSION
  end

  def test_run
    Timer.run
  end
end
