class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def new
     @item = Item.new(:snapshot_id => params[:id])


  end
  def show
    @user_items = current_user.items if user_signed_in?
    @item = Item.find(params[:id])
    @snapshot = Snapshot.find(@item.snapshot_id)

  end
  def edit
      @item = Item.find(params[:id])
  end


  def destroy
    @item = Item.find(params[:id])
    @id = @item.snapshot_id
      Item.find(params[:id]).destroy
       redirect_to :controller => 'snapshots',:action => 'show', :id => @id
  end
  def create
    @item = Item.new(params[:item])
    #@snapshot = Snapshot.find(@temp.snapshot_id)

    #@item  = @snapshot.items.build(params[:item])
    @snapshot = Snapshot.find(@item.snapshot_id)
    @item.photo = @snapshot.photo
    if @item.save
      #if params[:item][:photo].blank?
      #flash[:success] = "Item created!"
      #redirect_to @item
      #else
      render :action => 'crop'
      #end
    else
      flash[:success] = nil
      render :action => "new"
    end
  end
  def update
  @item = Item.find(params[:id])
  @snapshot = Snapshot.find(@item.snapshot_id)
  @item.photo = @snapshot.photo
  if @item.update_attributes(params[:item])
    if params[:commit] == "Crop"
      flash[:notice] = "Successfully updated user."
      redirect_to @item
    else
      render :action => "crop"
    end
  else
    render :action => 'edit'
  end
end

end
