class OrdersController < ApplicationController
  before_action :item_setting, only: :index
  before_action :move_to_login

  def index
    redirect_to root_path if @item.user == current_user
  end

  private

  def item_setting
    @item = Item.find(params[:item_id])
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

end
