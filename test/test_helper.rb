# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "debug"
require "timer"

require "minitest/autorun"

ENV["TIMER_ENV"] ||= "test"

module StubNow
  # 2023-03-11 07:27:49 2284889/4194304 -0800
  FROZEN_IN_TIME = 1_678_548_469.54_476
  NOW_IN_NANOS = 1_678_548_469_544_759_988

  def stub_now(&)
    Time.stub(:now, Time.at(FROZEN_IN_TIME), &)
  end
end
