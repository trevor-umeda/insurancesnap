require 'spec_helper'

describe Item do


   it "can be created" do
     expect {
         Factory(:item)
     }.should change(Item, :count).by(1)
   end


  it "should have a name to be valid" do
    no_name_item = Factory.build(:item,:name => "")
    no_name_item.should_not be_valid
    no_name_item.errors[:name].should_not be_empty
  end

  it "should have a description to be valid" do
    no_desc_item = Factory.build(:item,:description => "")
    no_desc_item.should_not be_valid
  end

  it "should have a valid price" do
    wrong_price = Factory.build(:item,:price => "a string")
    wrong_price.should_not be_valid
  end

   describe "cropping values " do
     before(:each) do
       @item = Item.new()
     end
  it "should have selection of crop values" do
    @item.should respond_to(:crop_x)
    @item.should respond_to(:crop_y)
    @item.should respond_to(:crop_h)
    @item.should respond_to(:crop_w)
  end

    it "should have a cropping? method" do
      @item.should respond_to(:cropping?)
  end
  it "should be cropping" do
    @item.crop_x = 10
    @item.crop_y = 10
    @item.crop_h = 10
    @item.crop_w = 10
    @item.cropping?.should be true
  end
     end
end
