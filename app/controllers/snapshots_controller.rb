class SnapshotsController < ApplicationController

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
      Snapshot.find(params[:id]).destroy
       redirect_to :controller => 'users',:action => 'show', :id => @id
  end
  def show
    @snapshot = Snapshot.find(params[:id])
     @item = Item.new
  end

end
