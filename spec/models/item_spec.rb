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
      @item.images = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Images can't be blank")
    end
    it 'status_idが選択されていないと出品できない' do
      @item.status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Status を選択してください")
    end
    it 'category_idが選択されていないと出品できない' do
      @item.category_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Category を選択してください")
    end
    it 'prefecture_idが選択されていないと出品できない' do
      @item.prefecture_id = '0'
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture を選択してください")
    end
    it 'shipping_fee_status_idが選択されていないと出品できない' do
      @item.shipping_fee_status_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee status を選択してください")
    end
    it 'scheduled_delivery_idが選択されていないと出品できない' do
      @item.scheduled_delivery_id = '1'
      @item.valid?
      expect(@item.errors.full_messages).to include("Scheduled delivery を選択してください")
    end
    it 'priceが空では出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
    it 'priceが300以下では出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end
    it 'priceが9999999以上では出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end
    it 'priceが半角数字以外では出品できない' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
    it 'userが紐づいていなければ出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
  end
end
