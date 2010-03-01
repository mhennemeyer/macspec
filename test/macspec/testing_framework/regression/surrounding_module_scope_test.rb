require File.dirname(__FILE__) + "/../test_helper.rb"

module Hello
  module Again
    def hello_again
      "hello_again"
    end
  end
end

module Hello
  module Again
    describe "Surrounding Module" do
      it "has access to surrounding module" do
        hello_again.should eql("hello_again")
      end

      describe "in nested context" do
        it "has access to surrounding module" do
          hello_again.should eql("hello_again")
        end
      end
    end
  end
end