require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録できるとき' do
    it '必須項目が全て存在すれば登録できる' do
      expect(@user).to be_valid
    end
  end
  context '新規登録できないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailに@が含まれていないと登録できない' do
      @user.email = 'eamil'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'emailが既に登録されていると登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが英数字混合でなければ登録できない' do
      @user.password = '111111'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end
    it 'passwordが一致していなければ登録できない' do
      @user.password_confirmation = '111kkk'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'first_nameが全角ひらがな、カタカナ、漢字以外では登録できない' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'last_nameが全角ひらがな、カタカナ、漢字以外では登録できない' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
    end
    it 'first_name_readingが空では登録できない' do
      @user.first_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading can't be blank")
    end
    it 'first_name_readingが全角カタカナ以外では登録できない' do
      @user.first_name_reading = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading is invalid. Input full-width katakana characters")
    end
    it 'last_name_readingが空では登録できない' do
      @user.last_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading can't be blank")
    end
    it 'last_name_readingが全角カタカナ以外では登録できない' do
      @user.last_name_reading = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading is invalid. Input full-width katakana characters")
    end
    it 'birthdayが空では登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
