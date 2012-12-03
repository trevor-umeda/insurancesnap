require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "should not accept invalid registration" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      lambda do
      visit new_user_registration_path

        fill_in "Email",        :with => ""
        fill_in "Password",     :with => ""
      fill_in "Password confirmation",     :with => ""

        click_button
        end.should_not change(User,:count)
    end

    it "should accept valid registration" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      lambda do
      visit new_user_registration_path

        fill_in "Email",        :with => "test@email.com"
        fill_in "Password",     :with => "password"
      fill_in "Password confirmation",     :with => "password"

        click_button
        end.should change(User,:count).by(1)
    end

    it "should login successfully" do
      @user = Factory(:user)
      visit new_user_session_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button

      response.should render_template('users/index')
    end

    it "should not login successfully with improper values" do
    @user = Factory(:user)
    visit new_user_session_path
    fill_in "Email", :with => ""
    fill_in "Password", :with => ""
    click_button

    response.should_not render_template('users/index')
    end



  end
end
