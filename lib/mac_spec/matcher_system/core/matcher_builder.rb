module MacSpec
  module MatcherSystem
    module MatcherBuilder
      def build_matcher(matcher_name=nil, args=[], &block)
        match_block = lambda do |actual, matcher|
          block.call(actual, matcher, args)
        end
        body = lambda do |klass|
          @matcher_name = matcher_name.to_s
          def self.matcher_name
            @matcher_name
          end

          attr_accessor :positive_msg, :negative_msg, :msgs
          alias :positive_failure_message  :positive_msg
          alias :positive_failure_message= :positive_msg=
          alias :negative_failure_message  :negative_msg
          alias :negative_failure_message= :negative_msg=
          alias :chained_messages  :msgs
          attr_reader :matcher_name
          def initialize(match_block, test_case)
            @match_block, @test_case = match_block, test_case
            @matcher_name = self.class.matcher_name
          end

          def method_missing(id, *args, &block)
            require 'ostruct'
            (self.msgs ||= []) << OpenStruct.new( "name" => id, "args" => args, "block" => block ) 
            self
          end

          def matches?(given)
            @positive_msg ||= "Matching with '#{matcher_name}' failed, although it should match."
            @negative_msg ||= "Matching with '#{matcher_name}' passed, although it should_not match."
            @match_block.call(given, self)
          end

          alias_method :failure_message, :positive_msg
          alias_method :negative_failure_message, :negative_msg
        end
        Class.new(&body).new(match_block, self)
      end
    end
  end
end