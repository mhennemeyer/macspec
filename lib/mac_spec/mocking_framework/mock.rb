module MacSpec
  module MockingFramework
    class Mock
      @mock_space = []
      attr_reader :message_expectations
      def initialize(name, options={})
        @name = name
        @message_expectations = {}
        @belongs_to = options[:belongs_to] 
        Mock.mock_space << self 
        if options[:null_object]
          (class<<self;self;end).send(:define_method, :method_missing) do |name, *args, &block|
            Mock.new(:null_object, :null_object => true)
          end
        end
        options[:stubs] && options[:stubs].each do |stub_method, return_value|
          (class<<self;self;end).send(:define_method, stub_method) do |*args|
            return_value
          end
        end
      end

      def self.mock_space
        @mock_space
      end

      def self.verify
        @mock_space.each do |m|
          m && m.__verify
        end
        @mock_space = []
      end

      def __add_positive_message_expectation(msg)
        @message_expectations[msg] ||= MessageExpectation.new(msg, @name, true) 
      end

      def __add_negative_message_expectation(msg)
        @message_expectations[msg] ||= MessageExpectation.new(msg, @name, false)
      end
      
      def __add_stub(hash)
        mes = []
        hash.each do |msg, ret_val|
          me = MessageExpectation.new(msg, @name, true)
          me.stub!(ret_val)
          mes << me
        end
        mes
      end

      def __verify
        begin
          @message_expectations.each do |msg, me| 
            me.verify
          end
        ensure
          @belongs_to && @belongs_to.__macspec__reset!(self)
          @message_expectations = {}
        end
      end
    end
  end
end