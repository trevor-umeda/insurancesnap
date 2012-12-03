class ItemsController < ApplicationController
  before_filter :authenticate
  include ApplicationHelper

  def sort
    current_user.items.each do |item|
      item.position = params[ 'user' ].index(item.id.to_s) + 1
      item.save
    end
    render :nothing => true
    end

  def index
    if params[:search]
      @items = Item.find_all_by_user_id(current_user.id, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    else
      @items = current_user.items
    end
  end
  def new
     @item = Item.new(:snapshot_id => params[:id])
     @item.photo = Snapshot.find(params[:id]).photo


  end
  def show
    @user_items = current_user.items if user_signed_in?
    @item = Item.find(params[:id])
    @snapshot = Snapshot.find(@item.snapshot_id)
    respond_to do |format|
      format.html
      format.xml {render :xml => @item}
      end

  end
  def edit
      @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.xml {render :xml => @item}
      end
  end


  def destroy
    @item = Item.find(params[:id])
    @id = @item.snapshot_id
    @snapshot = Snapshot.find(@item.snapshot_id)
      Item.find(params[:id]).destroy
       respond_to do |format|
         format.html { redirect_to :controller => 'snapshots',:action => 'show', :id => @id }
         format.js
       end
  end
  def create
    @item = Item.new(params[:item])

    @snapshot = Snapshot.find(@item.snapshot_id)
    @item.user_id = @snapshot.user_id
    @item.photo = @snapshot.photo
    if @item.save
    @item.update_attributes(params[:item])
    respond_to do |format|
      format.html { redirect_to @item }
      format.js
      format.xml {render :xml => @item}
      end
    #  #if params[:item][:photo].blank?
    #  flash[:notice] = "Item created!"
    #  redirect_to @item
    #  #else
    #  #render :action => 'crop'
    #  #end
    else
      @error = @item.errors[:name]
      flash[:errors] = "Problems with your entry"
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js {redirect_to snapshot_path(@snapshot)}
      end
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

  private
  def authenticate
     deny_access unless user_signed_in?
  end

end
