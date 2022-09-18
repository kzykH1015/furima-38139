class UsersController < ApplicationController
  before_action :user_set
  def show
    @q = Item.ransack(params[:q])
    @items = @q.result
    @user_items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

  def edit
    redirect_to root_path if @user.id != current_user.id
    @user = User.new
  end

  def update

  end
  
  private
  
  def user_set
    @user = User.find(params[:id])
  end
end