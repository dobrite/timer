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
        { iterations: 3_000_000, logger: Loggers::Logger.new, interactions: }
      end

      def test_config
        {
          iterations: 100_000,
          logger: Loggers::NullLogger.new,
          interactions: []
        }
      end

      def interactions
        [
          Interaction.new(300_000..600_000, ->(sim) { sim.change_bpm(30) }),
          Interaction.new(
            600_000..1_200_000,
            ->(sim) { sim.periodics[2].mult = 4 }
          )
        ]
      end

      def test?
        ENV["TIMER_ENV"] == "test"
      end
    end

    def initialize(logger:, iterations:, interactions:)
      @bpm = Bpm.new(120)
      @logger = logger
      @iterations = iterations
      @interactions = interactions
    end

    def run
      loop
    end

    def change_bpm(new_bpm)
      bpm.bpm = new_bpm
      periodics.each(&:bpm_changed!)
    end

    def periodics
      @periodics ||= [
        Periodic.new(bpm, mult: 1),
        Periodic.new(bpm, mult: 0.5),
        Periodic.new(bpm, mult: 2),
        Periodic.new(bpm, mult: 4)
      ]
    end

    private

    attr_reader :bpm, :interactions, :iterations, :logger

    def loop
      iterations.times do |t|
        now = Nanos.now
        bpm.start(now) unless bpm.running?
        bpm.update(now)
        run_periodics(now)
        run_interactions(t)
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

    def run_interactions(iteration)
      interactions.each { |i| i.update(iteration, self) }
    end

    def outputs
      @outputs ||= [
        Output.new(logger:, name: "!"),
        Output.new(logger:, name: "0"),
        Output.new(logger:, name: "1"),
        Output.new(logger:, name: "2")
      ]
    end

    def log(message)
      logger.log(message)
    end
  end
end
