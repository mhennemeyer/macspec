require File.dirname(__FILE__) + '/../test_helper.rb'

module MacSpec
  module MatcherSystem
    module ExpectationBuilder
      describe "build_expectation" do

        before do
          @obj = Object.new
        end

        it "should" do
          exp = MacSpec::MatcherSystem::ExpectationBuilder.build_expectation(true, nil, @obj)
          exp.send(:==, @obj)
        end

        it "should fails" do
          expect_1 = MacSpec::MatcherSystem::ExpectationBuilder.build_expectation(true, nil, 1)
          lambda {expect_1.send(:==, 2)}.should raise_error
        end

        it "should not" do
          exp = MacSpec::MatcherSystem::ExpectationBuilder.build_expectation(false, nil, @obj)
          exp.send(:==, 1)
        end

        it "should not fails" do
          expect_not_1 = MacSpec::MatcherSystem::ExpectationBuilder.build_expectation(false, nil, 1)
          lambda {expect_not_1.send(:==, 1)}.should raise_error
        end
      end
    end
  end
end
