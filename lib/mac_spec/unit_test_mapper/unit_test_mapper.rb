module MacSpec
  class UnitTestMapper
    class << self
      def add_test_case(tc)
        (@test_cases ||= []) << tc
      end

      def test_cases
        @test_cases
      end

      def add_focused_test(tc,fit)
        @focused_tests ||= {}
        (@focused_tests[tc] ||= []) << fit
      end

      def focused_tests
        @focused_tests
      end

      def create_shared_examples(name, block)
        (@shared_example_groups ||= {}).update({name => block})
      end

      def shared_example_group_for(name)
        @shared_example_groups && @shared_example_groups[name]
      end

      def test_case_class
        MiniTest::Unit::TestCase
      end

      def assertion_failed_error
        MiniTest::Assertion
      end
    end
  end
end