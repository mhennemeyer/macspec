$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


require "testing_framework/core/test_case_class_methods"
require "testing_framework/core/kernel_extension"
require "testing_framework/core/functions"