# frozen_string_literal: true

module Timer
  # Nanosecond
  class Nano
    def self.now
      Time.now.nsec
    end
  end
end
