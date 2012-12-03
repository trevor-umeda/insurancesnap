require 'spec_helper'

describe ItemsController do
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
        get :show, :id => @item
        response.should be_success
      end
  end

  describe "Creating an item" do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      sign_in @user
      @attr = Factory.attributes_for(:item)
      @snapshot = Factory(:snapshot)
    end

    it "should create a item" do
      lambda do
        post :create, :item => @attr
       end.should change(Item, :count).by(1)
    end

    it "should redirect correctly after creating a item" do
      post:create, :item => @attr
      response.should redirect_to(item_path(assigns[:item]))
    end

    it "should create a relationship using Ajax" do
      lambda do
        xhr :post, :create, :item => @attr
        response.should be_success
      end.should change(Item, :count).by(1)
    end
  end

  describe "Deleting an Item" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Factory(:user)
      sign_in @user
       @item = Factory(:item)
      @snapshot = Factory(:snapshot)
    end

    it "should destroy a relationship using Ajax" do
      lambda do
        xhr :delete, :destroy, :id => @item
        response.should be_success
      end.should change(Item, :count).by(-1)
    end
  end

  describe "editing an item" do

      before(:each) do
       @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = Factory(:user)
        sign_in @user
        @item = Factory(:item)
       @snapshot = Factory(:snapshot)
      end

    it "should be successful to try" do
      get :edit, :id => @item
      response.should be_success
    end

     it "should have the right title at the edit screen" do
      get :edit, :id => @item
      response.should have_selector("h1", :content => "Edit Items")
    end
  end

end
