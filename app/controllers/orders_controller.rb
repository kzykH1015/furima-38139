class OrdersController < ApplicationController
  before_action :item_setting, only: [:index, :create]
  before_action :move_to_login
  before_action :sold_out
  before_action :move_to_new_card
  before_action :card_find

  def index
    redirect_to root_path if @item.user == current_user
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
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
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: current_user.card.customer_token
    )
  end

  def sold_out
    redirect_to root_path if Order.exists?(item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def move_to_new_card
    redirect_to new_card_path and return unless current_user.card.present?
  end

  def card_find
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: current_user.id)

    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end
end
