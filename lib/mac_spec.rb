require "rubygems"
require "minitest/unit"
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module MacSpec
  class << self
    
    def assert(bool=false)
      @current_test_case.assert(bool)
    end
    
    def flunk(msg="No Error Message given.")
      @current_test_case.flunk(msg)
    end
    
    def current_test_case
      @current_test_case 
    end
    
    def current_test_case=(tc)
      @current_test_case = tc
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
MiniTest::Unit.autorun unless defined?(MacSpecNoAutoRun)
require 'mac_spec/matcher_system'
require 'mac_spec/testing_framework'
require 'mac_spec/mocking_framework'
unless defined?(LOADED)
  # Track the current testcase and 
  # provide it to the operator matchers and mocking framework.
  # Otherwise expectations won't be counted as assertions
  # todo no global
  MacSpec.test_case_class.class_eval do
    alias_method :old_run_method_aliased_by_macspec, :run
    def run(whatever, *args, &block)
      MacSpec.current_test_case = self
      old_run_method_aliased_by_macspec(whatever, *args, &block)
    end
  end
  LOADED = true
end

MacSpec.test_case_class.send(:include, MacSpec::MatcherSystem::Expectations::TestCaseExtensions)
include MacSpec::MatcherSystem::DefMatcher