require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers
  render_views

    describe " User access controls" do

      before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factory.create(:user)
      sign_in user
     end
      it "should have a current_user" do
          subject.current_user.should_not be_nil
      end

    end

   describe "testing users show" do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]

      @user = Factory(:user)

      sign_in @user
      @user.snapshots << Factory(:snapshot)

    end

    it "show should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns[:user_snapshots].should == @user.snapshots
    end
   end


end
