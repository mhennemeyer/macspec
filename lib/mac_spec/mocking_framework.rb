$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "mocking_framework/message_expectation"
require "mocking_framework/mock"
require "mocking_framework/extensions/kernel_extension"
require "mocking_framework/extensions/object_extension"

module MacSpec
  module MockingFramework
    # doc
  end
end