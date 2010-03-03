module MacSpec
  module MockingFramework
    class MessageExpectation
      attr_reader :msg, :return_value
      def initialize(msg, receiver, positive)
        @receiver = receiver
        @msg = msg
        @positive = positive
        @return_value = {}
        @received = {}
        @args_expectation = :__macspec_anyargs
      end

      def verify
        unless self.stub?
          @return_value.each do |args,value|
            args_string = (args == :__macspec_anyargs) ? "Any Args" : args.inspect
            if (@received[args] && @positive) || (!@received[args] && !@positive)
              MacSpec.assert(true)
            elsif (!@received[args] && @positive)
              err_msg = "'#{@receiver}' should have received '#{msg}' with '#{args_string}'."
              MacSpec.flunk err_msg
            elsif (@received[args] && !@positive)
              err_msg = "'#{@receiver}' should *not* have received '#{msg}' with '#{args_string}'."
              MacSpec.flunk err_msg
            end
          end
        end
        @return_value = {}
      end
      
      def stub!(ret_val)
        @return_value[:__macspec_anyargs] = ret_val
        @stub = true
        self
      end
      
      def stub?
        @stub
      end
      
      def unique_alias
        "__macspec__alias_for_#{@msg}".to_sym
      end

      def received_with_args!(args)
        @received[args] = true unless args == nil
        @received[:__macspec_anyargs] = true
        @return_value[:__macspec_anyargs] ||= true
      end

      def return_value_for_args(args)
        args ||= :__macspec_anyargs
        received_args = @return_value.keys
        unless received_args.include?(args) || received_args.include?(:__macspec_anyargs)
          args_string = args == :__macspec_anyargs ? "No Args" : args
          err_msg = "Wrong Argument(s): '#{args_string}' For message '#{msg}'. Receiver: '#{@receiver}'"
          MacSpec.flunk err_msg
        end
        @return_value[args]
      end

      def with_args(*args)
        @args_expectation = args
        @return_value[@args_expectation] = nil
        self
      end

      def and_return(value)
        if @positive
          @return_value[@args_expectation] = value
          self
        end
      end
    end
  end
end