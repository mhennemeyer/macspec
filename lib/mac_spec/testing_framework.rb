$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


require "testing_framework/core/test_case_class_methods"
require "testing_framework/core/kernel_extension"
require "testing_framework/core/functions"

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
    #######################################|                              |############
    methods = public_instance_methods(true).select{|m|method_defined?(m)}.grep(/^test/).map { |m|
    #######################################|                              |############
      m.to_s
    }.sort

    if self.test_order == :random then
      max = methods.size
      methods = methods.sort_by { rand(max) }
    end

    methods
  end
end

# Filter tests if there are focused examples
at_exit do
  if MacSpec::UnitTestMapper.focused_tests
    MacSpec::UnitTestMapper.test_cases.each do |testcase|
      for test in testcase.own_tests
        unless MacSpec::UnitTestMapper.focused_tests[testcase] && MacSpec::UnitTestMapper.focused_tests[testcase].include?(test)
          testcase.send(:undef_method, test) while(testcase.send(:method_defined?, test))
        end
      end
    end
  end
end

module MacSpec
  module TestingFramework
    # todo doc
  end
end