require File.dirname(__FILE__) + '/../spec_helper.rb'

module MacSpec
  module MatcherSystem
    describe "change matcher" do
      before do
        @var = 1
      end

      it "passing" do
        lambda {@var += 1}.should change {@var}
      end

      it "change fails" do
        lambda do
          lambda { }.should change {@var} 
        end.should raise_error
      end

      it "change by" do
        lambda {@var += 1}.should change {@var}.by(1)
      end

      it "change by fails" do
        lambda do
          lambda {@var += 2}.should change {@var}.by(1) 
        end.should raise_error
      end

      it "change by at least" do
        lambda {@var += 1}.should change {@var}.by_at_least(1)
      end

      it "change by at least fails" do
        lambda do
          lambda {@var += 0.9}.should change {@var}.by_at_least(1)
        end.should raise_error
      end

      it "change by at most" do
        lambda {@var += 1}.should change {@var}.by_at_most(1)
      end

      it "change by at most fails" do
        lambda do
          lambda {@var += 1.1}.should change {@var}.by_at_most(1)
        end.should raise_error
      end

      it "change from to" do
        lambda {@var += 1}.should change {@var}.from(1).to(2)
      end

      it "change from to fails" do
        lambda do
          lambda {@var += 1.1}.should change {@var}.from(1).to(2)
        end.should raise_error
      end

      it "raises unsupported message sent" do
        lambda do
          lambda {@var += 1.1}.should change {@var}.unsupported_message
        end.should raise_error Exceptions::UnsupportedMessageSentToMatcher
      end
    end
    
  end
end