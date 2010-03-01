
def mock(name, options={})
  MacSpec::Mock.new(name, options)
end
module MacSpec
  

  class PositiveMessageExpectationNotMet < StandardError;end
  class NegativeMessageExpectationNotMet < StandardError;end

  class MessageExpectation
    attr_reader :msg, :return_value
    def initialize(msg, receiver, positive)
      @receiver = receiver
      @msg = msg
      @positive = positive
      @return_value = {}
      @received = {}
      @args_expectation = nil
    end

    def verify
      @return_value.each do |args,value|
        unless @received[args]
          err_msg = "'#{@receiver}' should have received '#{msg}' with '#{args}'."
          @positive ? p_err(err_msg) : n_err(err_msg)
        end
      end
    end

    def unique_alias
      "__macspec__alias_for_#{@msg}".to_sym
    end

    def received_with_args!(args=nil)
      @received[args] = true
    end

    def p_err(err_msg)
      raise PositiveMessageExpectationNotMet.new(err_msg)
    end

    def n_err(err_msg)
      raise NegativeMessageExpectationNotMet.new(err_msg)
    end

    def return_value_for_args(args=[])
      unless @return_value.keys.include?(args)
        err_msg = "Illegal Argument(s): '#{args}' For message '#{msg}'. Receiver: '#{@receiver}'"
        @positive ? p_err(err_msg) : n_err(err_msg)
      end
      @return_value[args]
    end

    def with_args(*args)
      @args_expectation = args
      @return_value[@args_expectation] = nil
      self
    end

    def and_return(value)
      @return_value[@args_expectation || []] = value
      self
    end
  end

  class Mock
    attr_reader :message_expectations
    def initialize(name, options={})
      @name = name
      @message_expectations = {}
      @belongs_to = options[:belongs_to] 
      ($__macspec__all_mocks ||= []) << self # todo no globals
      if options[:null_object]
        (class<<self;self;end).send(:define_method, :method_missing) do |name, *args, &block|
          mock("null", :null_object => true)
        end
      end
    end

    def add_positive_message_expectation(msg)
      @message_expectations[msg] ||= MessageExpectation.new(msg, @name, true) 
    end

    def add_negative_message_expectation(msg)
      @message_expectations[msg] ||= MessageExpectation.new(msg, @name, false)
    end

    def verify
      begin
        @message_expectations.each do |msg, me| 
          unless me.verify 
            raise PositiveMessageExpectationNotMet.new(
              "#{@name} should have received #{msg}.")
          end
        end
      ensure
        @belongs_to && @belongs_to.__macspec__reset!(self)
      end
    end
  end

  class Object
    def should_receive(msg)
      @__macspec__mock ||= Mock.new(self.to_s, :belongs_to => self)
      __macspec__proxy_service(@__macspec__mock.add_positive_message_expectation(msg))
    end

    def should_not_receive(msg)
      @__macspec__mock ||= Mock.new(self.to_s)
      __macspec__proxy_service(@__macspec__mock.add_negative_message_expectation(msg))
    end

    def __macspec__reset!(mock)
      mock.message_expectations.each do |msg,me|
        if respond_to?(me.unique_alias) && respond_to?(me.msg)
          (class<<self;self;end).instance_eval do 
            undef_method me.msg
            alias_method me.msg, me.unique_alias
            undef_method me.unique_alias
          end
        else
        end
      end
      @__macspec__mock = nil
    end

    def __macspec__proxy_service(me)
      if respond_to?(me.msg) && !respond_to?(me.unique_alias)
        (class<<self;self;end).send(:alias_method, me.unique_alias, me.msg)
        (class<<self;self;end).send(:define_method, me.msg) do |*args| # todo care about args with_args ...
          me.received_with_args!(args)
          me.return_value_for_args(args)
        end
      else
        # 
      end

      me
    end
  end
end