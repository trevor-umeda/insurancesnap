class UsersController < ApplicationController
  def index
    if user_signed_in?
      @current_user = current_user

    end
    @snapshot = Snapshot.new if user_signed_in?
  end

  def show
    @user = User.find(params[:id])
    @user_snapshots = current_user.snapshots if user_signed_in?
    respond_to do |format|
      format.html
      format.xml {render :xml => @user_snapshots}
    end
  end

end
