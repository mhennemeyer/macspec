module MacSpec
  module ExpectationBuilder
    def self.build_expectation(match, exp, obj)
      return MacSpec::Expectations::OperatorExpectation.new(obj, match) unless exp
      
      (exp.matches?(obj) != match) ? exp.fail!(match) : exp.pass!(match)
    end
  end
end