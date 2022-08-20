require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  context '新規登録できるとき' do
    it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      # @userに対してバリデーションが全て正常に合っているか確認
      expect(@user).to be_valid
    end
  end
  context '新規登録できないとき' do
    it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      # @userに対してバリデーションが全て正常に合っているか確認
      expect(@user).to be_valid
    end
  end
end
