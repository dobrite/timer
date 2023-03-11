# frozen_string_literal: true

require_relative "timer/bpm"
require_relative "timer/nanos"
require_relative "timer/millis"
require_relative "timer/version"

# Times stuff
module Timer
  SECONDS_PER_MINUTE = 60
  NANOS_PER_SECOND = 1_000_000_000

  class Error < StandardError
  end

  def run
    puts "Running!"
    bpm = Bpm.new(120, Nanos.now.value)
    5_000_000.times do
      now_ns = Nanos.now.value
      bpm.update(now_ns)
    end
    puts "Done!"
  end
  module_function :run
end
