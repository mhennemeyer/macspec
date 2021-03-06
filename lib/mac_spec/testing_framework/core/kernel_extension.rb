
module Kernel
  
  def shared_examples_for(sym, &block)
    MacSpec::UnitTestMapper.create_shared_examples(sym, block)
  end
  
  def describe(*args, &block)
    super_class = (Hash === args.last && (args.last[:type] || args.last[:testcase])) || MacSpec::UnitTestMapper.test_case_class 
    super_class.class_eval {extend MacSpec::TestingFramework::TestCaseClassMethods} 
    # MacSpec::SpecTestMapper.create_example_group(name: context: )
    cls = Class.new(super_class)
    cnst, desc = args
    cnst = MacSpec::TestingFramework::Functions.make_constantizeable(cnst)
    Object.const_set MacSpec::TestingFramework::Functions::determine_class_name(cnst.to_s + "Test"), cls
    cls.desc = String === desc ? desc : cnst.to_s
    if self.class.to_s == "Module"
      orig_block = block
      mod_context = self
      #mods = self.ancestors.select {|m| m.class.to_s == "Module"}
      block = lambda {include mod_context; instance_eval(&orig_block)}
    end
    cls.teardown_chained = lambda {MacSpec::MockingFramework::MessageExpectation.verify}
    cls.macspec_superclass = super_class
    MacSpec::UnitTestMapper.add_test_case(cls)
    cls.class_eval(&block)
    cls.testcases.each do |testcase|
      for test in cls.all_tests.reject {|t| testcase.own_tests.include?(t)}
        testcase.send(:undef_method, test) if testcase.send(:method_defined?, test)
      end
    end
  end
  private :describe
end # Kernel
