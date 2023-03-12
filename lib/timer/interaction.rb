module Timer
  # Models something happening to the simulation
  # e.g. changing bpm or mult
  class Interaction
    def initialize(range, lambda)
      @trigger_iteration = rand(range)
      @lambda = lambda
      @applied = false
    end

    def update(iteration, sim)
      return unless !applied && iteration > trigger_iteration

      @lambda.call(sim)
      @applied = true
    end

    private

    attr_reader :applied, :trigger_iteration
  end
end
