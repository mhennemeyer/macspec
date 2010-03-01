require "rubygems"
require "minitest/unit"
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

unless defined?(Test::Unit) || defined?(MiniTest)
  raise "No Testing library present! Either Test::Unit or MiniTest must be required before loading matchy" 
end

# MacSpec works with MiniTest
module MacSpec
  class << self
    def classic?
      false
    end

    def minitest?
      !minitest_tu_shim?
    end

    def minitest_tu_shim?
      defined?(Test::Unit::TestCase) && defined?(MiniTest::Assertions) && Test::Unit::TestCase < MiniTest::Assertions
    end

    def assertions_module
      MiniTest::Assertions
    end

    def test_case_class
      MiniTest::Unit::TestCase
    end

    def assertion_failed_error
      MiniTest::Assertion
    end
  end
end
MiniTest::Unit.autorun
require 'macspec/matcher_system'
require 'macspec/testing_framework'
require 'macspec/mocking_framework'
unless defined?(LOADED)
  # Track the current testcase and 
  # provide it to the operator matchers.
  # Otherwise operator expectations won't be counted
  MacSpec.test_case_class.class_eval do
    alias_method :old_run_method_aliased_by_matchy, :run
    def run(whatever, *args, &block)
      $current_test_case = self
      old_run_method_aliased_by_matchy(whatever, *args, &block)
    end
  end
  LOADED = true
end

MacSpec.test_case_class.send(:include, MacSpec::Expectations::TestCaseExtensions)
include MacSpec::DefMatcher