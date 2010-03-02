require File.dirname(__FILE__) + "/../test_helper.rb"

module MacSpec
  module MockingFramework
    describe KernelExtension do
      include MacSpec::MockingFramework::KernelExtension
      
      describe "mock(name, options)" do
        before do
          @mock = mock("mock")
        end
        
        it "creates a Mock" do
          @mock.should be_kind_of(Mock)
        end
        
        describe "null_object => true" do
          before do
            @null = mock("mock", :null_object => true)
          end

          it "creates a null" do
            @null.hello?
          end
          
          it "returns another null for each method call" do
            @null.hello?.should be_kind_of(Mock)
          end
          
          it "and so on ..." do
            @null.hello?.hello?.hello?.should be_kind_of(Mock)
          end
        end
      end
    end
  end
end