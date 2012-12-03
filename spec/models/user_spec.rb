require 'spec_helper'

describe User do
  describe "creating a user" do



   it "can be created" do
     expect {
         Factory(:user)
     }.should change(User, :count).by(1)
   end

   it "should have an email to be valid" do
    no_name_user = Factory.build(:user,:email => "")
    no_name_user.should_not be_valid
    no_name_user.errors[:email].should_not be_empty
  end

  it "should have a password to be valid" do
    no_password_user = Factory.build(:user,:password => "")
    no_password_user.should_not be_valid
    no_password_user.errors[:password].should_not be_empty
  end
    it "should have a matching password confirmation to be valid" do
    wrong_password_user = Factory.build(:user,:password_confirmation => "password2")
    wrong_password_user.should_not be_valid
  end
  end

   describe "should have the correct sets of objects" do
     it "should have set of snapshots" do
       @user = User.new()
       @user.should respond_to(:snapshots)
     end

     it "should have a set of items" do
       @user = User.new()
       @user.should respond_to(:items)
     end
   end


end
