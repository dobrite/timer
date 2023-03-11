require_relative "timer/bpm"
require_relative "timer/nanos"
require_relative "timer/periodic"
require_relative "timer/version"
require_relative "timer/output"
require_relative "timer/loggers/logger"
require_relative "timer/loggers/null_logger"

# Times stuff
module Timer
  SECONDS_PER_MINUTE = 60
  NANOS_PER_SECOND = 1_000_000_000

  def run
    Simulator.run(logger:)
  end
  module_function :run

  def logger
    ENV["TIMER_ENV"] == "test" ? Loggers::NullLogger.new : Loggers::Logger.new
  end
  module_function :logger

  # Simulates everything running
  class Simulator
    def self.run(logger:)
      new(logger:).run
    end

    def initialize(logger:)
      @logger = logger
    end

    def run
      log "Running!"
      bpm = Bpm.new(120)
      outputs = (0...6).map { |i| Output.new(logger:, index: i) }
      periodics = (0...6).map { |_| Periodic.new(bpm, Nanos.now.value) }
      5_000_000.times do
        now_ns = Nanos.now.value
        periodics.each_with_index { |p, i| p.update(now_ns, outputs[i]) }
      end
      log "Done!"
    end

    private

    attr_reader :logger

    def log(message)
      logger.log(message)
    end
  end
end
