# frozen_string_literal: true

require_relative "timer/nanos"
require_relative "timer/millis"
require_relative "timer/version"

# Times stuff
module Timer
  class Error < StandardError
  end

  def run
    puts "Running!"
    puts "Done!"
  end
  module_function :run
end
