module MacSpec
  module MockingFramework
    module ObjectExtension
      def should_receive(msg)
        # @__macspec_message_expectations ||= []
        # options = {}
        # message_expectation = MacSpec::MockingFramework::MessageExpectation.new(options)
        # @__macspec_message_expectations << message_expectation
        # return message_expectation
        @__macspec__mock ||= MacSpec::MockingFramework::Mock.new(self.to_s, :belongs_to => self)
        __macspec__proxy_service(@__macspec__mock.__add_positive_message_expectation(msg))
      end

      def should_not_receive(msg)
        @__macspec__mock ||= MacSpec::MockingFramework::Mock.new(self.to_s,:belongs_to => self)
        __macspec__proxy_service(@__macspec__mock.__add_negative_message_expectation(msg))
      end
      
      def stub!(hash)
        @__macspec__mock ||= MacSpec::MockingFramework::Mock.new(self.to_s, hash)
        __macspec__proxy_service(@__macspec__mock.__add_stub(hash))
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

      def __macspec__proxy_service(mes)
        mes = (mes.class == Array) ? mes : [mes]
        mes.map do |me|
          # todo refactor duplication
          if respond_to?(me.msg) && !respond_to?(me.unique_alias)
            # todo refactor to singletonclass.instance_eval
            (class<<self;self;end).send(:alias_method, me.unique_alias, me.msg)
            (class<<self;self;end).send(:define_method, me.msg) do |*args|
              received_args = args == [] ? nil : args
              me.received_with_args!(received_args)
              me.return_value_for_args(received_args)
            end
          elsif !respond_to?(me.msg) && !respond_to?(me.unique_alias)
             (class<<self;self;end).send(:define_method, me.msg) do |*args|
               received_args = args == [] ? nil : args

               me.received_with_args!(received_args)
               me.return_value_for_args(received_args)
             end
          else
            # 
          end

          me
        end.first
      end
    end
  end
end

Object.send(:include, MacSpec::MockingFramework::ObjectExtension)