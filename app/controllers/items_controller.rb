class ItemsController < ApplicationController
  before_action :move_to_login, except: [:index, :show]
  before_action :item_finding, only: [:show, :edit, :update, :destroy]

  def index
    @items_list = Item.all.order('created_at DESC')
    @q = Item.ransack(params[:q])
    @items = @q.result
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @q = Item.ransack(params[:q])
    @items = @q.result

    all_item_id = Item.pluck(:id)
    now_item = all_item_id.index(@item.id)
    @next_item_id = all_item_id[now_item + 1]
    @before_item_id = all_item_id[now_item - 1]
    @limit_high = all_item_id.max
    @item_id_low = all_item_id[0]
  end

  def edit
    redirect_to root_path if @item.user.id != current_user.id || Order.exists?(item_id: @item.id)
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
    @item_form.tag_name = @item.tags&.first&.tag_name
  end

  def update
    @item_form = ItemForm.new(item_form_params)

    @item_form.images ||= @item.images.blobs
    if @item_form.valid?
      @item_form.update(item_form_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    end
  end

  def search_tag
    return nil if params[:keyword] == ''

    tag = Tag.where(['tag_name LIKE?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  def search_item
    if params[:q]&.dig(:name)
      squished_keywords = params[:q][:name].squish
      params[:q][:name_cont_any] = squished_keywords.split(' ')
    end
    @q = Item.ransack(params[:q])
    @items = @q.result
  end

  private

  def item_form_params
    params.require(:item_form).permit(
      :name, :price, :info, :status_id, :category_id, :shipping_fee_status_id,
      :prefecture_id, :scheduled_delivery_id, :tag_name, { images: [] }
    ).merge(user_id: current_user.id)
  end

  def item_finding
    @item = Item.find(params[:id])
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end
end
