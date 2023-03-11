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
      logger.log "Running!"
      new(logger:).run
      logger.log "Done!"
    end

    def initialize(logger:)
      now_ns = Nanos.now.value
      @bpm = Bpm.new(120, now_ns)
      @logger = logger
    end

    def run
      5_000_000.times do
        now_ns = Nanos.now.value
        periodics.each_with_index do |p, i|
          if i == periodics.length - 1
            p.update(now_ns, logger)
          else
            p.update(now_ns, outputs[i])
          end
        end
      end
    end

    private

    attr_reader :bpm, :logger

    def outputs
      @outputs ||= (0...4).map { |i| Output.new(logger:, index: i) }
    end

    def periodics
      return @periodics if defined?(@periodics)

      @periodics ||= (0...4).map { |i| Periodic.new(bpm, mult: i + 1) }
      @periodics << Periodic.new(bpm, mult: 4)
      @periodics
    end

    def log(message)
      logger.log(message)
    end
  end
end
