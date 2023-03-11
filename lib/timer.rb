# frozen_string_literal: true

require_relative "timer/nanos"
require_relative "timer/millis"
require_relative "timer/version"

# Times stuff
module Timer
  NANOS_PER_SECOND = 1_000_000_000

  class Error < StandardError
  end

  def run
    puts "Running!"
    puts "Done!"
  end
  module_function :run
end
