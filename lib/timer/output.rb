# frozen_string_literal: true

module Timer
  class Output
    def initialize(index:, logger:)
      @index = index
      @logger = logger
    end

    def trigger
      logger.log(index.to_s)
    end

    private

    attr_reader :index, :logger
  end
end
