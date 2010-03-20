require File.dirname(__FILE__) + '/../spec_helper.rb'

describe MacSpec::MatcherSystem::Modals do
  before do
    @expectation = build_matcher() {|r,m,a| true}
    @bad_expectation = build_matcher() {|r,m,a| false}
  end
  
  it "should" do
    3.should(@expectation)
  end
  
  it "will" do
    3.will(@expectation)
  end
  
  it "should not" do
    3.should_not(@bad_expectation)
  end
  
  it "will not" do
    3.will_not(@bad_expectation)
  end
  
  it "wont" do
    3.wont(@bad_expectation)
  end
  
  it "should operator expectation returned" do
    obj = 3.should
    assert_equal MacSpec::MatcherSystem::Expectations::OperatorExpectation, obj.class
  end
  
  
  it "should not operator expectation returned" do
    obj = 3.should_not
    assert_equal MacSpec::MatcherSystem::Expectations::OperatorExpectation, obj.class
  end
end
