require 'spec_helper'

describe SnapshotsController do
  include Devise::TestHelpers
    render_views

    describe " failed access control" do

      it "should deny access to 'index'" do
        get :index
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'show" do
        get :show, :id => 1
        response.should redirect_to(new_user_session_path)
      end

      it "should deny access to 'destroy" do
        delete :destroy, :id => 1
        response.should redirect_to(new_user_session_path)
      end

       it "should deny access to 'create" do
        post :create
        response.should redirect_to(new_user_session_path)
      end
    end

  describe "successful access control" do

     before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      sign_in @user

       @item = Factory(:item)
       @snapshot = Factory(:snapshot)
     end


      it "should get index" do
        get :index
       response.should be_success
      end

      it "should get show" do
        get :show, :id => @snapshot
        response.should be_success
      end
  end
  describe "Creating a snapshot" do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      sign_in @user
      @attr = Factory.attributes_for(:snapshot)
      @snapshot = Factory(:snapshot)
    end

    it "should create a snapshot" do
      lambda do
        post :create, :snapshot => @attr
       end.should change(Snapshot, :count).by(1)
    end

    it "should redirect correctly after creating a snapshot" do
      post:create, :snapshot => @attr
      response.should redirect_to(snapshot_path(assigns[:snapshot]))
    end


  end
   describe "Deleting an Item" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      sign_in @user
      @snapshot = Factory(:snapshot)
    end

    it "should destroy a relationship using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @snapshot
        response.should be_success
      end.should change(Snapshot, :count).by(-1)
    end
    end
end
