module Timer
  # Simulates everything running
  class Simulator
    class << self
      def run
        new(**config).run
      end

      private

      def config
        test? ? test_config : run_config
      end

      def run_config
        { iterations: 5_000_000, logger: Loggers::Logger.new }
      end

      def test_config
        { iterations: 100_000, logger: Loggers::NullLogger.new }
      end

      def test?
        ENV["TIMER_ENV"] == "test"
      end
    end

    def initialize(logger:, iterations:)
      @bpm = Bpm.new(120)
      @logger = logger
      @iterations = iterations
    end

    def run
      start
      loop
    end

    private

    attr_reader :bpm, :iterations, :logger

    def start
      now = Nanos.now
      bpm.start(now)
    end

    def loop
      iterations.times do
        now = Nanos.now
        bpm.update(now)
        run_periodics(now)
      end
    end

    def run_periodics(now)
      periodics.each_with_index do |p, i|
        if i == periodics.length - 1
          p.update(now, logger)
        else
          p.update(now, outputs[i])
        end
      end
    end

    def outputs
      @outputs ||= [Output.new(logger:, name: "!")]
    end

    def periodics
      @periodics ||= [Periodic.new(bpm, mult: 1), Periodic.new(bpm, mult: 1)]
    end

    def log(message)
      logger.log(message)
    end
  end
end
