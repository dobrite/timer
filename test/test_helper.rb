# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "timer"

require "minitest/autorun"

module StubNow
  # 2023-03-11 07:27:49 2284889/4194304 -0800
  FROZEN_IN_TIME = 1678548469.54476

  def stub_now
    Time.stub :now, Time.at(FROZEN_IN_TIME) do
      yield
    end
  end
end
