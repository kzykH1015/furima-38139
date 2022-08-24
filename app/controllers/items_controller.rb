class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    item_finding
  end

  def edit
    item_finding
    redirect_to root_path if @item.user.id != current_user.id
  end

  def update
    item_finding
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :price, :info, :status_id, :category_id, :shipping_fee_status_id,
      :prefecture_id, :scheduled_delivery_id, :image
    ).merge(user_id: current_user.id)
  end

  def item_finding
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end
end
