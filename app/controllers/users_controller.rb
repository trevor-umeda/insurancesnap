class UsersController < ApplicationController
  def index
    if user_signed_in?
      @current_user = current_user

    end
    @snapshot = Snapshot.new if user_signed_in?
  end

  def show
    @user_snapshots = current_user.snapshots if user_signed_in?
  end

end
