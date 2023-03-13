module Timer
  # A simulated output
  class Output
    def initialize(name:, index:, logger:)
      @name = name
      @index = index
      @logger = logger
    end

    def trigger
      logger.write(index, name.to_s)
    end

    private

    attr_reader :index, :logger, :name
  end
end
