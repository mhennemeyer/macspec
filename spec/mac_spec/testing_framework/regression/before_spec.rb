require File.dirname(__FILE__) + "/../spec_helper.rb"

describe "top level" do
  
  before do
    @horst = "Horst"
  end
  
  it "example1" do
    @horst.should eql("Horst")
  end
  
  describe "second level" do
    
    before do
      @inge = "Inge"
      @horst = "NoHorst!"
    end
    
     it "there should be NoHorst" do
      @horst.should eql("NoHorst!")
    end
    
    it "Inge should be here" do
      @inge.should be("Inge")
    end  
  end
  
  it "Horst should still be Horst" do
    @horst.should be("Horst")
  end
end
