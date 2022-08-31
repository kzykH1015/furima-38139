require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    sleep(0.1)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_address).to be_valid
    end
    it 'buildingは空でも保存できること' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end
  context '内容に問題がある場合' do
    it 'userが紐づいていないと保存できないこと' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end
    it 'itemが紐づいていないと保存できないこと' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
    it 'tokenが空では保存できないこと' do
      @order_address.token = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it 'postal_codeが空では保存できないこと' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeに「-」がないと保存できないこと' do
      @order_address.postal_code = '1113333'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code にはハイフン(-)を入れてください')
    end
    it 'prefectureが選択されていないと保存できないこと' do
      @order_address.prefecture_id = '0'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture を選択してください')
    end
    it 'cityが空では保存できないこと' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it 'addressが空では保存できないこと' do
      @order_address.address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end
    it 'phone_numberが空では保存できないこと' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが半角数字以外では保存できないこと' do
      @order_address.phone_number = '１１１２２２２３３３３'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number は半角数字で10桁か11桁の番号を入力してください')
    end
    it 'phone_numberが9桁以下では保存できないこと' do
      @order_address.phone_number = '123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number は半角数字で10桁か11桁の番号を入力してください')
    end
    it 'phone_numberが12桁以上では保存できないこと' do
      @order_address.phone_number = '123456789012'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number は半角数字で10桁か11桁の番号を入力してください')
    end
  end
end
