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

# This MonkeyPatch is here, because MacRuby fails to really ignore methods that have
# been removed or undefined. The following code snippet will put out *true* with MacRuby 
# and *false* with other Ruby versions:
#
#      class A
#        def meth  
#        end
#      end
#      
#      A.send(:remove_method, :meth)
#      puts A.new.methods.include?(:meth)
#
# 
MiniTest::Unit::TestCase.class_eval do
  def self.test_methods
    methods = public_instance_methods(true).select{|m|method_defined?(m)}.grep(/^test/).map { |m|
      m.to_s
    }.sort

    if self.test_order == :random then
      max = methods.size
      methods = methods.sort_by { rand(max) }
    end

    methods
  end
end

MiniTest::Unit.autorun unless defined?(MacSpecNoAutoRun)
require 'mac_spec/version'
require 'mac_spec/matcher_system'
require 'mac_spec/testing_framework'
require 'mac_spec/mocking_framework'

at_exit do
  if MacSpec.focused_tests
    MacSpec.test_cases.each do |testcase|
      for test in testcase.own_tests
        unless MacSpec.focused_tests[testcase] && MacSpec.focused_tests[testcase].include?(test)
          while(testcase.send(:method_defined?, test))
            testcase.send(:undef_method, test) if testcase.send(:method_defined?, test)
          end
        end
      end
    end
  end
end

unless defined?(LOADED)
  # Track the current testcase and 
  # provide it to the operator matchers and mocking framework.
  # Otherwise expectations won't be counted as assertions
  # todo no global
  MacSpec.test_case_class.class_eval do
    alias_method :old_run_method_aliased_by_macspec, :run
    def run(runner, *args, &block)
      MacSpec.current_test_case = self
      old_run_method_aliased_by_macspec(runner, *args, &block)
    end
  end
  LOADED = true
end

MacSpec.test_case_class.send(:include, MacSpec::MatcherSystem::Expectations::TestCaseExtensions)
include MacSpec::MatcherSystem::DefMatcher