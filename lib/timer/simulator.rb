module Timer
  # Simulates everything running
  class Simulator
    class << self
      def run
        logger.log "Running!"
        new(logger:, iterations:).run
        logger.log "Done!"
      end

      private

      def logger
        test? ? Loggers::NullLogger.new : Loggers::Logger.new
      end

      def iterations
        test? ? 100_000 : 5_000_000
      end

      def test?
        ENV["TIMER_ENV"] == "test"
      end
    end

    def initialize(logger:, iterations:)
      now_ns = Nanos.now.value
      @bpm = Bpm.new(120, now_ns)
      @logger = logger
      @iterations = iterations
    end

    def run
      iterations.times do
        now_ns = Nanos.now.value
        bpm.update(now_ns, logger)
        #periodics.each_with_index do |p, i|
        #  if i == periodics.length - 1
        #    p.update(now_ns, logger)
        #  else
        #    p.update(now_ns, outputs[i])
        #  end
        #end
      end
    end

    private

    attr_reader :bpm, :iterations, :logger

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
