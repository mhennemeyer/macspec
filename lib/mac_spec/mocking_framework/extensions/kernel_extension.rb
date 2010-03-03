module MacSpec
  module MockingFramework
    module KernelExtension
      def mock(name, options={})
        mock_options = {}
        mock_options[:null_object] = options.delete(:null_object)
        mock_options[:stubs] = options
        MacSpec::MockingFramework::Mock.new(name,mock_options)
      end
    end
  end
end

Kernel.send(:include, MacSpec::MockingFramework::KernelExtension)