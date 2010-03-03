require File.dirname(__FILE__) + "/../test_helper.rb"

describe MacSpec::TestingFramework::Functions do
  
  describe "determine_class_name(name)" do
    it "Horst -> Horst" do
       MacSpec::TestingFramework::Functions::determine_class_name("Horst").should eql("Horst")
    end
    
    it "HorstTest -> HorstTest" do
       MacSpec::TestingFramework::Functions::determine_class_name("HorstTest").should eql("HorstTest")
    end
    
    it "HorstTest Hello -> HorstTestHello" do
       MacSpec::TestingFramework::Functions::determine_class_name("HorstTest Hello").should eql("HorstTestHello")
    end
    
    it "Horst test hello -> HorstTestHello" do
       MacSpec::TestingFramework::Functions::determine_class_name("Horst test hello").should eql("HorstTestHello")
    end
  end
  
  describe "#make_constantizeable(string)" do
    it "returns arg if arg is not a string" do
       MacSpec::TestingFramework::Functions.make_constantizeable(1).should eql(1)
    end
    
    it "removes nonword chars" do
       MacSpec::TestingFramework::Functions.make_constantizeable("@hello").should eql("hello")
    end
    
    it "dosn't remove undescores" do
       MacSpec::TestingFramework::Functions.make_constantizeable("_hel_lo").should eql("_hel_lo")
    end
    
    it "removes leading numbers" do
       MacSpec::TestingFramework::Functions.make_constantizeable("11hello").should eql("hello")
    end
    
    it "removes leading numbers but not undescores" do
       MacSpec::TestingFramework::Functions.make_constantizeable("11_hello").should eql("_hello")
    end
    
    it "doesn't remove inline whitespace" do
       MacSpec::TestingFramework::Functions.make_constantizeable("h e l l o").should eql("h e l l o")
    end
    
    it "removes leading whitespace" do
       MacSpec::TestingFramework::Functions.make_constantizeable(" hello").should eql("hello")
       MacSpec::TestingFramework::Functions.make_constantizeable("1 hello").should eql("hello")
       MacSpec::TestingFramework::Functions.make_constantizeable("1 1 @ hello").should eql("hello")
    end
  end
  
  describe "#string?" do
    it "recognizes a String" do
      MacSpec::TestingFramework::Functions.string?("string").should be(true)
    end
    
    [1, 1.0, true, false, /regex/, (1..2), class<<self;end].each do |thing|
      it "recognizes #{thing} to not be a string" do
        MacSpec::TestingFramework::Functions.string?(thing).should be(false)
      end
    end
  end
end