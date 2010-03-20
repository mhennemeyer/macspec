require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "Enumerable Expectations" do
  it "include" do
    [1,2,3,4].should include(4)
  end
  
  it "include fail" do
    lambda {
      [1,2,3,4].should include(6)
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "exclude" do
    [1,2,3,4].should exclude(9)
  end
  
  it "exclude fail" do
    lambda {
      [1,2,3,4].should exclude(4)
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "multi include" do
    [1,2,3,4].should include(1,2)
  end
  
  it "multi include fail" do
    lambda {
      [1,2,3,4].should include(6,7,8)
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "multi exclude" do
    [1,2,3,4].should exclude(13,14)
  end
  
  it "multi exclude fail" do
    lambda {
      [1,2,3,4].should exclude(2,3,4)
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "negative include" do
    [1,2,3,4].should_not include(9)
  end
  
  it "negative include fail" do
    lambda {
      [1,2,3,4].should_not include(4)
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "negative exclude" do
    [1,2,3,4].should_not exclude(3)
  end
  
  it "negative exclude fail" do
    lambda {
      [1,2,3,4].should_not exclude(6,7)
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "include fail message" do
    obj = include(1)
    obj.matches?([4,5,6])
    
    obj.failure_message.should be("Expected [4, 5, 6] to include [1].")
  end
  
  it "include negative fail message" do
    obj = include(1)
    obj.matches?([4,5,6])
    
    obj.negative_failure_message.should be("Expected [4, 5, 6] to not include [1].")
  end
  
  it "exclude fail message" do
    obj = exclude(4)
    obj.matches?([4,5,6])
    
    obj.failure_message.should be("Expected [4, 5, 6] to exclude [4].")
  end
  
  it "exclude negative fail message" do
    obj = exclude(4)
    obj.matches?([4,5,6])
    
    obj.negative_failure_message.should be("Expected [4, 5, 6] to not exclude [4].")
  end
end
