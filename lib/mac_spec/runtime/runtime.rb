module MacSpec
  # Track the current testcase that is run by MiniTest and 
  # provide it to the operator matchers and the mocking framework.
  # Otherwise expectations wouldn't be counted as assertions
  module Runtime
    class << self
      def current_test_case
        @current_test_case 
      end

      def set_current_test_case(tc)
        @current_test_case = tc
      end

      def report_expectation_met
        @current_test_case.assert(true)
      end

      def report_expectation_missed(msg="No Error Message given.")
        @current_test_case.flunk(msg)
      end
    end
  end
end

unless defined?(LOADED)
  MacSpec::UnitTestMapper.test_case_class.class_eval do
    alias_method :old_run_method_aliased_by_macspec, :run
    def run(runner, *args, &block)
      MacSpec::Runtime.set_current_test_case(self)
      old_run_method_aliased_by_macspec(runner, *args, &block)
    end
  end
  LOADED = true
end