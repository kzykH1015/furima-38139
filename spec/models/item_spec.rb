require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '新規出品できるとき' do
    it '必須項目が全て存在すれば登録できる' do
      expect(@item).to be_valid
    end
  end
  context '新規出品できないとき' do
    it 'nameが空では出品できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it 'infoが空では出品できない' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Info can't be blank")
    end
    it 'imageが空では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'status_idが選択されていないと出品できない' do
      @item.status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end
    it 'category_idが選択されていないと出品できない' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'prefecture_idが選択されていないと出品できない' do
      @item.prefecture_id = '0'
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'shipping_fee_status_idが選択されていないと出品できない' do
      @item.shipping_fee_status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
    end
    it 'scheduled_delivery_idが選択されていないと出品できない' do
      @item.scheduled_delivery_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
    end
    it 'priceが空では出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが300以下では出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it 'priceが9999999以上では出品できない' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
    it 'priceが半角数字以外では出品できない' do
      @item.price = "１０００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
  end
end
