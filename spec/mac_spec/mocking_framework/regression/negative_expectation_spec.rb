require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Negative Message Expactation" do
  
  describe "with class methods" do
    before do
      class A
        def self.meth
          "class meth"
        end
      end
    end

    it "works" do 
      A.should_not_receive(:blah)
    end
  end
  
  describe "with instance methods" do
    before do
      class A
        def meth
          "instance meth"
        end
      end
    end

    it "works" do 
      A.new.should_not_receive(:blah)
    end
  end
    
end