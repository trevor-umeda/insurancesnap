require 'spec_helper'

describe Snapshot do
  describe "it should have proper creation properties" do
   it "can be created" do
     expect {
         Factory(:snapshot)
     }.should change(Snapshot, :count).by(1)
   end


   it "should have a title to be valid" do
    no_title_snap = Factory.build(:snapshot,:title => "")
    no_title_snap.should_not be_valid
  end

    it "should have a photo to be valid" do
    no_photo_snap = Factory.build(:snapshot,:photo => "")
    no_photo_snap.should_not be_valid
    end
   end

  describe "it should have correct set of other values" do
    before(:each) do
      @snapshot = Snapshot.new()
    end
    it "should have a set of items" do
      @snapshot.should respond_to(:items)
    end


    end
end
