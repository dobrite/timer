require_relative "timer/bpm"
require_relative "timer/interaction"
require_relative "timer/nanos"
require_relative "timer/output"
require_relative "timer/periodic"
require_relative "timer/simulator"
require_relative "timer/version"
require_relative "timer/loggers/logger"
require_relative "timer/loggers/null_logger"
require_relative "timer/triggers"

# Times stuff
module Timer
  SECONDS_PER_MINUTE = 60
  NANOS_PER_SECOND = 1_000_000_000

  def run
    Simulator.run
  end
  module_function :run
end
