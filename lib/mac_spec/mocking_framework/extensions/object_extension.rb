module MacSpec
  module MockingFramework
    module ObjectExtension
      def should_receive(msg)
        @__macspec__mock ||= MacSpec::MockingFramework::Mock.new(self.to_s, :belongs_to => self)
        __macspec__proxy_service(@__macspec__mock.add_positive_message_expectation(msg))
      end

      def should_not_receive(msg)
        @__macspec__mock ||= MacSpec::MockingFramework::Mock.new(self.to_s)
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
      end
    end
  end
end

Object.send(:include, MacSpec::MockingFramework::ObjectExtension)