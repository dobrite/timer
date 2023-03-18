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
        { iterations: 15_000_000, logger: Loggers::Logger.new, interactions: }
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
            ->(sim) { sim.triggers[2].mult = 4 }
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
    end

    def fan_out
      @fan_out ||= Triggers::FanOut.new(triggers, final_trigger: logger)
    end

    def triggers
      @triggers ||=
        [[0, 1], [1, 2], [2, 0.5], [3, 8]].map do |output, mult|
          Triggers::Periodic.new(bpm.resolution, outputs[output], mult:)
        end
    end

    private

    attr_reader :bpm, :interactions, :iterations, :logger

    def loop
      iterations.times do |t|
        now = Nanos.now
        bpm.start(now) unless bpm.running?
        bpm.update(now, triggerable: fan_out)
        run_interactions(t)
      end
    end

    def run_interactions(iteration)
      interactions.each { |i| i.update(iteration, self) }
    end

    def outputs
      @outputs ||=
        %w[! 0 1 2].map.with_index do |name, index|
          Output.new(logger:, index:, name:)
        end
    end

    def log(message)
      logger.log(message)
    end
  end
end
