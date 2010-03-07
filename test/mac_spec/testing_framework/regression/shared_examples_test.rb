require File.dirname(__FILE__) + "/../test_helper.rb"

shared_examples_for "blahing objects" do
  it "can blah" do
    @object.should respond_to(:blah)
  end
end

describe "shared examples" do
  before do
    @object = Object.new
    def @object.blah
      "blah"
    end
  end
  
  it_should_behave_like "blahing objects"
  
end