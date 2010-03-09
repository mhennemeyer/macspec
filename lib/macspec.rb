require "rubygems"
require "minitest/unit"
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))



MiniTest::Unit.autorun unless defined?(MacSpecNoAutoRun)
require 'mac_spec/version'
require 'mac_spec/unit_test_mapper'
require 'mac_spec/runtime'
require 'mac_spec/matcher_system'
require 'mac_spec/testing_framework'
require 'mac_spec/mocking_framework'

module MacSpec
  #config...
end

MacSpec::UnitTestMapper.test_case_class.send(:include, MacSpec::MatcherSystem::Expectations::TestCaseExtensions)
include MacSpec::MatcherSystem::DefMatcher