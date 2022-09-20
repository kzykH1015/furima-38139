class UsersController < ApplicationController
  before_action :user_set
  def show
    @q = Item.ransack(params[:q])
    @items = @q.result
    @user_items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

  private

  def user_set
    @user = User.find(params[:id])
  end
end
