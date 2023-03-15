require "test_helper"

module Timer
  module Triggers
    class TestPeriodic < Minitest::Test
      class TestTrigger
        attr_reader :count

        def initialize
          @count = 0
        end

        def trigger
          @count += 1
        end
      end

      def test_mult_one_half
        resolution = 24
        test_trigger = TestTrigger.new
        periodic = Triggers::Periodic.new(resolution, test_trigger, mult: 0.5)
        (resolution * 4).times { periodic.trigger }

        assert_equal 2, test_trigger.count
      end

      def test_mult_one
        resolution = 24
        test_trigger = TestTrigger.new
        periodic = Triggers::Periodic.new(resolution, test_trigger, mult: 1)
        (resolution * 4).times { periodic.trigger }

        assert_equal 4, test_trigger.count
      end

      def test_mult_two
        resolution = 24
        test_trigger = TestTrigger.new
        periodic = Triggers::Periodic.new(resolution, test_trigger, mult: 2)
        (resolution * 4).times { periodic.trigger }

        assert_equal 8, test_trigger.count
      end
    end
  end
end
