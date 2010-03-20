require File.dirname(__FILE__) + "/../spec_helper.rb"

shared_examples_for "blahing objects" do
  it "can blah" do
    @object.should respond_to(:blah)
  end
end

shared_examples_for "mooing objects" do
  it "can moo" do
    @object.should respond_to(:moo)
  end
end

shared_examples_for "nested: blahing objects" do
  it "can blah" do
    @object.should respond_to(:blah)
  end
  
  it_should_behave_like "blahing objects"
end

shared_examples_for "nested: mooing objects" do
  it "can moo" do
    @object.should respond_to(:moo)
  end
  
  it_should_behave_like "mooing objects"
end

shared_examples_for "deeper nested: blahing, mooing objects" do
  it "can blah" do
    @object.should respond_to(:blah)
  end
  
  it_should_behave_like "nested: blahing objects"
  it_should_behave_like "nested: mooing objects"
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

describe "nested shared examples of blahing objects" do
  before do
    @object = Object.new
    def @object.blah
      "blah"
    end
  end
  
  it_should_behave_like "nested: blahing objects"
  
end

describe "deeper nested shared examples" do
  before do
    @object = Object.new
    def @object.blah
      "blah"
    end
    
    def @object.moo
      "moo"
    end
  end
  it_should_behave_like "nested: blahing objects"
  it_should_behave_like "nested: mooing objects"
  it_should_behave_like "deeper nested: blahing, mooing objects"

end