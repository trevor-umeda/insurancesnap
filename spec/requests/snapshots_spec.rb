require 'spec_helper'

describe "Snapshots" do
  describe "If not logged in" do


    it "should NOT allow access to " do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      @snapshot = Factory(:snapshot)
      visit snapshot_path(@snapshot)
      response.should_not render_template('snapshots/show')
    end
  end
  describe "If logged in" do

    before(:each) do
       @user = Factory(:user)
      visit new_user_session_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button
    end

    it "should allow access to " do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      @snapshot = Factory(:snapshot)
      visit snapshot_path(@snapshot)
      response.should render_template('snapshots/show')
    end

    it "should display an error with incorrect fields" do
      visit users_path
      fill_in "Title", :with => ""

      click_button
      assert_contain("There were problems with the following fields:")
    end

    it "process snapshot with correct fields" do
      visit users_path
      fill_in "Title", :with => "Title room"
      fill_in "snapshot_photo", :with => File.new(Rails.root + 'spec/images/rails.png')
      click_button
      assert_not_contain("There were problems with the following fields:")
      response.should render_template('snapshots/show')
      assert_contain("Enter New Item Info")

    end
  end
end
