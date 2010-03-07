module MacSpec
  module MatcherSystem
    module ExpectationBuilder
      def self.build_expectation(match, exp, obj)
        return MacSpec::MatcherSystem::Expectations::OperatorExpectation.new(obj, match) unless exp

        (exp.matches?(obj) != match) ? MacSpec.flunk(match ? exp.failure_message : exp.negative_failure_message) : MacSpec.assert(true)
      end
    end
  end
end