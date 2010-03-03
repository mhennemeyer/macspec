module MacSpec
  module MatcherSystem
    module DefMatcher
      include MacSpec::MatcherSystem::MatcherBuilder
      def def_matcher(matcher_name, &block)
        Kernel.module_eval do
          define_method matcher_name do |*args|
            build_matcher(matcher_name, args, &block)
          end
        end
      end
    end
  end
end
