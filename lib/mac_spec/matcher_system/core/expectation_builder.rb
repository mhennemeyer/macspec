module MacSpec
  module MatcherSystem
    module ExpectationBuilder
      def self.build_expectation(match, exp, obj)
        unless exp
          return MacSpec::MatcherSystem::Expectations::OperatorExpectation.new(obj, match) 
        end

        if (exp.matches?(obj) != match) 
          msg = match ? exp.failure_message : exp.negative_failure_message
          MacSpec::Runtime.report_expectation_missed(msg)
        else 
          MacSpec::Runtime.report_expectation_met
        end
      end
    end
  end
end