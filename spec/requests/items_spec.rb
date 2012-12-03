require 'spec_helper'

describe "Items" do
  describe "GET /items" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit items_path
      response.status.should be(200)
    end
  end
  describe "If not logged in" do
    it "should NOT allow access to " do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      @snapshot = Factory(:snapshot)
      @item = Factory(:item)
      visit item_path(@item)
      response.should_not render_template('items/show')
    end
  end
  describe "if logged in" do
    before(:each) do
       @user = Factory(:user)
      visit new_user_session_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button
    end
    it "should allow access to " do
         @snapshot = Factory(:snapshot)
      @item = Factory(:item)
      visit item_path(@item)
      response.should render_template('items/show')
    end

    it "should not create a new item would invalid entries" do
      lambda do
        @snapshot = Factory(:snapshot)
      visit snapshot_path(@snapshot)
      fill_in "Name", :with => ""
      fill_in "Description", :with => ""
      fill_in "Price", :with => "hi"
      click_button
        end.should_not change(Item,:count)
    end
    it "should be able to create a new item"do
      lambda do
      @snapshot = Factory(:snapshot)
      visit snapshot_path(@snapshot)
      fill_in "Name", :with => "Chair"
      fill_in "Description", :with => "Its a chair"
      fill_in "Price", :with => 3
      click_button
        end.should change(Item,:count).by(1)
         response.should render_template("items/show")
    end

    describe "inventory check" do
      before(:each) do
        @item = Factory(:item)
        @item2 = Item.create(:name => "desk", :description => "a desk", :price => 33)
      @snapshot = Factory(:snapshot)
      @snapshot.items << @item
        @snapshot.items << @item2
        @user.snapshots << @snapshot
      end

      it "should have a correct inventory" do
      visit items_path
      assert_contain(@item.name)
      assert_contain(@item2.name)
      end

      it "inventory should allow access to items" do
        visit items_path
      click_link @item.name
      response.should render_template("items/show")
      assert_contain(@item.name)
      assert_contain(@item.description)
      assert_not_contain(@item2.description)

    end

    it "should search correctly" do

      visit items_path
      assert_contain(@item.name)
      assert_contain(@item2.name)
      fill_in "Search", :with => @item.name
      click_button
      assert_contain(@item.name)
      assert_not_contain(@item2.name)
    end
    end
  end
end
