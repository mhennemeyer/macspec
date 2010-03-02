module MacSpec
  module MockingFramework
    module KernelExtension
      def mock(name, options={})
        MacSpec::MockingFramework::Mock.new(name, options)
      end
    end
  end
end

Kernel.send(:include, MacSpec::MockingFramework::KernelExtension)