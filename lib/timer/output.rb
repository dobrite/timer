module Timer
  # A simulated output
  class Output
    def initialize(name:, logger:)
      @name = name
      @logger = logger
    end

    def trigger
      logger.append(name.to_s)
    end

    private

    attr_reader :logger, :name
  end
end
