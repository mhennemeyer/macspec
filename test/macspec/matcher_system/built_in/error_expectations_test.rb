require File.dirname(__FILE__) + '/../test_helper.rb'

describe "Error Expectations" do
  it "raises error" do
    lambda { raise "FAIL" }.should raise_error
  end
  
  it "raises error fail" do
    lambda {
      lambda { "WIN" }.should raise_error
    }.should raise_error(MacSpec.assertion_failed_error)
  end
  
  it "negative raises error" do
    lambda { "WIN" }.should_not raise_error
  end
  
  it "negative raises error fail" do
    lambda {
      lambda { raise "FAIL" }.should_not raise_error
    }.should raise_error(MacSpec.assertion_failed_error)
  end
  
  it "raises specific error" do
    lambda { raise TypeError }.should raise_error(TypeError)
  end
  
  it "raises specific error fail with no error" do
    lambda {
      lambda { "WIN" }.should raise_error(TypeError)
    }.should raise_error(MacSpec.assertion_failed_error)
  end
  
  it "raises specific error fail with different error" do
    lambda {
      lambda { raise StandardError }.should raise_error(TypeError)
    }.should raise_error(MacSpec.assertion_failed_error)
  end
  
  it "throws symbol" do
    lambda {
      throw :win
    }.should throw_symbol(:win)
  end
  
  it "throws symbol fails with different symbol" do
    lambda {
      lambda {
        throw :fail
      }.should throw_symbol(:win)
    }.should raise_error(MacSpec.assertion_failed_error)
  end
  
  it "negative throws symbol" do
    lambda {
      "not this time!"
    }.should_not throw_symbol(:win)
  end
  
  it "negative throws symbol fails with different symbol" do
    
    lambda{
      lambda {
        throw :fail
      }.should_not throw_symbol(:fail)
    }.should raise_error(MacSpec.assertion_failed_error)
  
  end
  
  it "error fail message" do
    obj = raise_error(TypeError)
    obj.matches?(lambda { raise NameError })
    
    obj.failure_message.should =~ /Expected #<(.*)> to raise TypeError, but NameError was raised instead./
  end
  
  it "error fail message when no error" do
    obj = raise_error(TypeError)
    obj.matches?(lambda { "moop" })
    
    obj.failure_message.should =~ /Expected #<(.*)> to raise TypeError, but none was raised./
  end
  
  it "error negative fail message" do
    obj = raise_error(TypeError)
    obj.matches?(lambda { raise TypeError })
    
    obj.negative_failure_message.should =~ /Expected #<(.*)> to not raise TypeError./
  end
  
  it "throw fail message" do
    obj = throw_symbol(:fail)
    obj.matches?(lambda { throw :lame })
    
    obj.failure_message.should =~ /Expected #<(.*)> to throw :fail, but :lame was thrown instead./
  end
  
  it "throw fail message when no symbol" do
    obj = throw_symbol(:fail)
    obj.matches?(lambda { "moop" })
    
    obj.failure_message.should =~ /Expected #<(.*)> to throw :fail, but no symbol was thrown./
  end
  
  it "throw negative fail message" do
    obj = throw_symbol(:fail)
    obj.matches?(lambda { throw :fail })
    
    obj.negative_failure_message.should =~ /Expected #<(.*)> to not throw :fail./
  end
  
  it "string argument message" do
    lambda {raise "message"}.should raise_error("message")
  end
  
  it "string argument message fails no error" do
    lambda do
      lambda { 1 }.should raise_error("message")
      
    end.should raise_error
  end
  
  it "string argument message fails wrong message" do
    lambda do
      lambda { raise "other message" }.should raise_error("message")
    end.should raise_error
  end
  
  it "regexp argument message" do
    lambda {raise "message"}.should raise_error(/essa/)
  end
  
  it "regexp argument message fails no error" do
    lambda do
      lambda { 1 }.should raise_error(/essa/)
    end.should raise_error
  end
  
  it "regexp argument message fails wrong message" do
    lambda do
      lambda { raise "other message" }.should raise_error(/abc/)
    end.should raise_error(/matching/)
  end
end
