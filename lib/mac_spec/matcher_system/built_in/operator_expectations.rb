module MacSpec
  module MatcherSystem
    module Expectations
      # Class to handle operator expectations.
      #
      # ==== Examples
      #   
      #   13.should == 13
      #   "hello".length.should_not == 2
      #
      class OperatorExpectation #< Base
        include ::MacSpec.assertions_module

        def initialize(receiver, match)
          @receiver, @match = receiver, match
        end

        ['==', '===', '=~', '>', '>=', '<', '<='].each do |op|
          define_method(op) do |expected|
            @expected = expected
            (@receiver.send(op,expected) ? true : false) == @match ? pass! : fail!(op)
          end
        end

        protected
        def pass!
          MacSpec.assert(true)
        end

        def fail!(operator)
          msg = @match ? failure_message(operator) : negative_failure_message(operator)
          MacSpec.flunk msg
        end

        def failure_message(operator)
          "Expected #{@receiver.inspect} to #{operator} #{@expected.inspect}."
        end

        def negative_failure_message(operator)
          "Expected #{@receiver.inspect} to not #{operator} #{@expected.inspect}."
        end
      end
    end
  end
end