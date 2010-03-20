require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "Operator Expectations" do

  it "equals (==)" do
    3.should == 3
  end
  
  it "equals fails" do
    lambda {
      3.should == 5
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "negative equals" do
    3.should_not == 4
  end
  
  it "negative equals fails" do
    lambda {
      3.should_not == 3
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end

  it "less than (<)" do
    3.should < 5
  end
  
  it "less than fails" do
    lambda {
      4.should < 3
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "less than equals" do
    3.should_not < 2
  end
  
  it "negative less than fails" do
    lambda {
      4.should_not < 5
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end 
  
  # GREATER THAN (>)
  it "greater than" do
    3.should > 2
  end
  
  it "greater than fails" do
    lambda {
      4.should > 5
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "greater than equals" do
    3.should_not > 5
  end
  
  it "negative greater than fails" do
    lambda {
      4.should_not > 3
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  # LESS THAN EQUAL (<=)
  it "less than equal" do
    3.should <= 5
  end
  
  it "less than equal equal" do
    3.should <= 3
  end
  
  it "less than equal fails" do
    lambda {
      4.should <= 3
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "negative less than equal" do
    3.should_not <= 2
  end
  
  it "negative less than equal fails" do
    lambda {
      4.should_not <= 5
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  # GREATER THAN EQUALS (>=)
  it "greater than equal" do
    3.should >= 2
  end
  
  it "greater than equal equals" do
    3.should >= 3
  end
  
  it "greater than equal fails" do
    lambda {
      4.should >= 5
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "negative greater than equal equals" do
    3.should_not >= 5
  end
  
  it "negative greater than equal fails" do
    lambda {
      4.should_not >= 3
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  # MATCHES (=~)
  it "matches" do
    "hey world".should =~ /world/
  end
  
  it "matches fails" do
    lambda {
      "d00d ur 1337".should =~ /world/
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
  
  it "negative matches" do
    "1337@age".should_not =~ /434/
  end
  
  it "negative matches fails" do
    lambda {
      "it's a freak out!".should_not =~ /freak/
    }.should raise_error(MacSpec::UnitTestMapper.assertion_failed_error)
  end
end
