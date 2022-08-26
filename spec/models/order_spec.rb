require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '購入できるとき' do
    it '必須項目が全て存在すれば購入できる' do
      expect(@order).to be_valid
    end
  end
  context '購入できないとき' do
    it 'userが紐づいていないと購入できない' do
      @order.user = nil
      @order.valid?
      expect(@order.errors.full_messages).to include('User must exist')
    end
    it 'itemが紐づいていないと購入できない' do
      @order.item = nil
      @order.valid?
      expect(@order.errors.full_messages).to include('Item must exist')
    end
  end
end
