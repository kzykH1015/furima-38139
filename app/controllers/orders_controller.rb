class OrdersController < ApplicationController
  before_action :item_setting, only: :index
  before_action :move_to_login

  def index
    redirect_to root_path if @item.user == current_user
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_setting
    @item = Item.find(params[:item_id])
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def order_params
    params.require(:donation_address).permit(:postal_code, :prefecture, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:id])
  end

end
