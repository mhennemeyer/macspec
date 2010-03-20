require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "Stubs" do
  describe "mock(name, :meth => 'return_value')" do
    [:any, :kind, :of, :method, :name].each do |m|
      ["string", 1, 1.0, Object.new].each do |val|
        it "returns #{val} for #{m}" do
          mock("name", m => val).send(m).should == val
        end
        
        it "stub!(#{m} => #{val})" do
          obj = Object.new
          obj.stub!(m => val)
          obj.send(m).should == val
        end
      end
    end
    
    it "stub!(:meth)" do
      obj = Object.new
      obj.stub!(:meth)
      lambda {obj.meth}.should_not raise_error
    end
    
    it "stub!(:meth1 => 1, :meth2 => 2, :meth3 => 3)" do
      obj = Object.new
      obj.stub!(:meth1 => 1, :meth2 => 2, :meth3 => 3)
      obj.meth1.should == 1
      obj.meth2.should == 2
      obj.meth3.should == 3
    end
    
  end
end