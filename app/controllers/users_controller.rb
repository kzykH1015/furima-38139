class UsersController < ApplicationController
  before_action :user_set
  def show
    @q = Item.ransack(params[:q])
    @items = @q.result
    @user_items = Item.where(user_id: params[:id]).order('created_at DESC')
  end

  def edit
    redirect_to root_path if @user.id != current_user.id
    user_attributes = @user.attributes
    @user = User.new(user_attributes)
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  private
  
  def user_set
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :avatar)
  end
end