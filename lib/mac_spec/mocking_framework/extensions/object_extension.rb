module MacSpec
  module MockingFramework
    module ObjectExtension
      def should_receive(msg)
        @__macspec__message_expectations ||= []
        options = {
          :receiver => self,
          :positive => true,
          :msg      => msg,
          :stub     => false
        }
        message_expectation = MacSpec::MockingFramework::MessageExpectation.new(options)
        @__macspec__message_expectations << message_expectation
        return message_expectation
        # @__macspec__mock ||= MacSpec::MockingFramework::Mock.new(self.to_s, :belongs_to => self)
        # __macspec__proxy_service(@__macspec__mock.__add_positive_message_expectation(msg))
      end

      def should_not_receive(msg)
        @__macspec__message_expectations ||= []
        options = {
          :receiver => self,
          :positive => false,
          :msg      => msg,
          :stub     => false
        }
        message_expectation = MacSpec::MockingFramework::MessageExpectation.new(options)
        @__macspec__message_expectations << message_expectation
        return message_expectation
      end
      
      def stub!(hash)
        hash = {hash => nil} unless Hash === hash
        @__macspec__message_expectations ||= []
        hash.each do |meth_to_stub, ret_val|
          options = {
            :receiver          => self,
            :positive          => true,
            :msg               => meth_to_stub,
            :stub              => true,
            :stub_return_value => ret_val
          }
          message_expectation = MacSpec::MockingFramework::MessageExpectation.new(options)
          @__macspec__message_expectations << message_expectation
        end
      end

      def __macspec__verify
        begin
          @__macspec__message_expectations && @__macspec__message_expectations.each do |me|
            me && me.verify
          end
        ensure
          __macspec__reset!
        end
      end
      
      def __macspec__reset!
        @__macspec__message_expectations && @__macspec__message_expectations.each do |me|
          if respond_to?(me.unique_alias) && respond_to?(me.msg)
            (class<<self;self;end).instance_eval do 
              undef_method me.msg
              alias_method me.msg, me.unique_alias
              undef_method me.unique_alias
            end
          else
          end
        end
        @__macspec__message_expectations = nil
      end
    end
  end
end

Object.send(:include, MacSpec::MockingFramework::ObjectExtension)