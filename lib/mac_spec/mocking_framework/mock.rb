module MacSpec
  module MockingFramework
    class Mock
      def initialize(name, options={})
        (class<<self;self;end).instance_eval do
          if options[:null_object]
            define_method :method_missing do |name, *args, &block|
              Mock.new(:null_object, :null_object => true)
            end
          end
          options[:stubs] && options[:stubs].each do |stub_method, return_value|
            define_method stub_method do |*args|
              return_value
            end
          end
        end
      end
    end
  end
end