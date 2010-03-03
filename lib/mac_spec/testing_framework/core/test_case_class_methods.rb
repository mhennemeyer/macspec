module MacSpec
  module TestingFramework
    # The methods defined in this module are available
    # inside the TestCases.
    module TestCaseClassMethods
      attr_accessor :desc, :setup_chained, :teardown_chained
      @desc ||= ""
      def setup_chained # :nodoc:
        @setup_chained || lambda {}
      end

      def teardown_chained # :nodoc:
        @teardown_chained || lambda {}
      end

      def testcases
        @@testcases ||= []
        @@testcases
      end

      def own_tests
        @own_tests ||= []
      end

      def all_tests
        @@_tests ||= []
      end
      
      def macspec_superclass
        @macspec_superclass
      end
      
      def macspec_superclass=(sc)
        @macspec_superclass = sc
      end

      # == Run before each Test.
      # The code in the block attached to this method will be run before each
      # test in all subsequent, eventually nested testcases.
      def setup(&block)
        passed_through_setup = self.setup_chained
        self.setup_chained = lambda { instance_eval(&passed_through_setup);instance_eval(&block) }
        define_method :setup, &self.setup_chained
      end
      alias before setup

      # == Run after each Test.
      # The code in the block attached to this method will be run after each
      # test in all subsequent, eventually nested testcases.
      def teardown(&block)
        passed_through_teardown = self.teardown_chained
        self.teardown_chained = lambda {instance_eval(&block);instance_eval(&passed_through_teardown) }
        define_method :teardown, &self.teardown_chained
      end
      alias after teardown

      # == Define a TestCase.
      def describe desc, &block
        cls = Class.new(macspec_superclass)
        mods = self.ancestors.reject {|m| Module === m }
        Object.const_set(self.name + desc.to_s.split(/\W+/).map { |s| s.capitalize }.join, cls)
        cls.setup_chained = self.setup_chained
        cls.teardown_chained = self.teardown_chained
        cls.macspec_superclass = self.macspec_superclass
        cls.desc = self.desc + " " + desc
        cls.tests($1.constantize) if defined?(Rails) && 
          self.name =~ /^(.*(Controller|Helper|Mailer))Test/ && 
            self < ActiveSupport::TestCase
        mods = self.ancestors.select {|m| m.class.to_s == "Module" }
        orig_block = block
        block = lambda {include *mods; instance_eval(&orig_block)} 
        cls.class_eval(&block)
        self.testcases << cls
      end

      # == Define a test.
      def it desc, &block
        self.setup {}
        desc = MacSpec::TestingFramework::Functions.make_constantizeable(desc)
        if block_given?
          test = "test_#{desc.gsub(/\W+/, '_').downcase}"
          define_method(test, &lambda {$current_spec = self; instance_eval(&block)})
          (@@_tests ||= []) << test.to_sym
          (@own_tests ||= []) << test.to_sym
        end
        self.teardown {}
      end
    end # TestCaseClassMethods
  end
end # MacSpec