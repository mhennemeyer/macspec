module MacSpec
  module MockingFramework
    class MessageExpectation
      @register = []
      attr_reader :msg, :return_value, :unique_alias
      def initialize(options)
        @receiver          = options[:receiver]
        @msg               = options[:msg]
        @positive          = options[:positive]
        @stub              = options[:stub]
        @stub_return_value = options[:stub_return_value]
        
        @unique_alias = "__macspec__alias_for_#{@msg}".to_sym
        me = self
        if respond_to?(@msg) && !respond_to?(@unique_alias)
          # todo refactor to singletonclass.instance_eval
          (class<<@receiver;self;end).send(:alias_method, @unique_alias, @msg)
          (class<<@receiver;self;end).send(:define_method, @msg) do |*args|
            received_args = args == [] ? nil : args
            me.received_with_args!(received_args)
            me.return_value_for_args(received_args)
          end
        elsif !respond_to?(@msg) && !respond_to?(@unique_alias)
           (class<<@receiver;self;end).send(:define_method, me.msg) do |*args|
             received_args = args == [] ? nil : args

             me.received_with_args!(received_args)
             me.return_value_for_args(received_args)
           end
        else
          # 
        end
        MessageExpectation.register_for_verification(@receiver)
        @return_value = {:__macspec_anyargs => true}
        @received = {}
        @args_expectation = :__macspec_anyargs
      end
      
      def self.register_for_verification(obj)
        @register << obj
      end
      
      def self.register
        @register
      end
      
      def self.verify
        begin
          @register.uniq.each do |obj|
            obj && obj.__macspec__verify
          end
        ensure
          @register = []
        end
      end
      
      def verify
        unless self.stub?
          @return_value.each do |args,value|
            args_string = (args == :__macspec_anyargs) ? "Any Args" : args.inspect
            if (@received[args] && @positive) || (!@received[args] && !@positive)
              
              MacSpec.assert(true)
            elsif (!@received[args] && @positive)
              received_with_args_string = if !@received.keys.include?(:__macspec_anyargs) 
                 "not at all."
               else
                 @received.delete(:__macspec_anyargs)
                 "#{@received.keys}"
               end
                
              err_msg = """
              '#{@receiver}' should have received '#{msg}' with '#{args_string}'.
              But received it #{received_with_args_string}
              """
              MacSpec.flunk err_msg
            elsif (@received[args] && !@positive)
              err_msg = "'#{@receiver}' should *not* have received '#{msg}' with '#{args_string}'."
              MacSpec.flunk err_msg
            end
          end
        end
        @return_value = {}
      end
      
      def stub?
        @stub
      end
      
      def negative?
        !@positive
      end

      def received_with_args!(args)
        @received[args] = true unless args == nil
        @received[:__macspec_anyargs] = true
        @return_value[:__macspec_anyargs] ||= true
      end

      def return_value_for_args(args)
        return @stub_return_value if stub?
        args ||= :__macspec_anyargs
        received_args = @return_value.keys
        unless received_args.include?(args) || received_args.include?(:__macspec_anyargs)
          args_string = args == :__macspec_anyargs ? "No Args" : args
          err_msg = "Wrong Argument(s): '#{args_string}' For message '#{msg}'. Receiver: '#{@receiver}'"
          MacSpec.flunk err_msg
        end
        @return_value[args]
      end

      def with(*args)
        unless stub?
          @args_expectation = args
          @return_value[@args_expectation] = nil
          self
        end
      end

      def and_return(value)
        unless stub? || negative?
          @return_value[@args_expectation] = value
          self
        end
      end
    end
  end
end