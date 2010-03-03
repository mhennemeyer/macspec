$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'matcher_system/core/expectation_builder'
require 'matcher_system/core/modals'
require 'matcher_system/core/matcher_builder'
require 'matcher_system/core/def_matcher'
require 'matcher_system/core/exceptions'

require 'matcher_system/built_in/enumerable_expectations'
require 'matcher_system/built_in/error_expectations'
require 'matcher_system/built_in/truth_expectations'
require 'matcher_system/built_in/operator_expectations'
require 'matcher_system/built_in/change_expectations'

module MacSpec
  module MatcherSystem
    # todo doc
  end
end