require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Mocking existing methods" do
  
  before do
    class A
      def self.noarg
        "noarg"
      end
      def self.onearg(arg)
        "onearg"
      end
      def self.twoargs(arg1, arg2)
        "twoargs"
      end
      def self.threeargs(arg1, arg2, arg3)
        "threeargs"
      end
    end
  end
  
  describe "not mocked" do
    it "noarg" do
      A.noarg.should eql("noarg")
    end
    
    it "onearg" do
      A.onearg("arg").should eql("onearg")
    end
    
    it "twoargs" do
      A.twoargs("arg1", "arg2").should eql("twoargs")
    end
    
    it "threeargs" do
      A.threeargs("arg1", "arg2", "arg3").should eql("threeargs")
    end
  end
  
  describe "Without args" do
    it "should work" do
      A.should_receive(:noarg).and_return("b")
      A.noarg.should eql("b")
    end
  end
  
  describe "With one arg" do 
    it "will take a number" do
      A.should_receive(:onearg).with(1).and_return("b")
      A.onearg(1).should eql("b")
    end
    
    it "will take a string" do
      A.should_receive(:onearg).with("string").and_return("b")
      A.onearg("string").should eql("b")
    end
    
    it "will take an array" do
      A.should_receive(:onearg).with([1,2,3]).and_return("b")
      A.onearg([1,2,3]).should eql("b")
    end
    
    it "will take an empty array" do
      A.should_receive(:onearg).with([]).and_return("b")
      A.onearg([]).should eql("b")
    end
    
    it "will take nil" do
      A.should_receive(:onearg).with(nil).and_return("b")
      A.onearg(nil).should eql("b")
    end
    
    it "will take a custom object" do
      obj = Object.new
      A.should_receive(:onearg).with(obj).and_return("b")
      A.onearg(obj).should eql("b")
    end
  end

  describe "Several Expectations on one class" do
    it "First Expectations, then calling" do
      A.should_receive(:noarg).and_return("b")
      A.should_receive(:onearg).and_return("b")
      A.noarg
      A.onearg
    end
    
    it "Mixed, but valid" do
      A.should_receive(:noarg).and_return("b")
      A.noarg
      A.should_receive(:onearg).and_return("b")
      A.onearg
    end
  end

end