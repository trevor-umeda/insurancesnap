class SnapshotsController < ApplicationController
     before_filter :authenticate
     include ApplicationHelper
     def index

     end
  def create
    @snapshot  = current_user.snapshots.build(params[:snapshot])
    if @snapshot.save
      flash[:success] = "Item created!"
      redirect_to @snapshot
    else
      flash[:success] = nil
      render 'users/index'
    end
  end

  def destroy
    @snapshot = Snapshot.find(params[:id])
    @id = @snapshot.user_id
    @user_snapshots = current_user.snapshots
      Snapshot.find(params[:id]).destroy
       respond_to do |format|
         format.html {redirect_to :controller => 'users',:action => 'show', :id => @id}
         format.js
       end
  end
  def show
    @snapshot = Snapshot.find(params[:id])
     @item = Item.new
    @item.snapshot_id = @snapshot.id
    @item.photo = @snapshot.photo
     @items = @snapshot.items
  end

  private
  def authenticate
     deny_access unless user_signed_in?

  end
end
