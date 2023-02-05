require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規機能' do

    it 'nickname, email, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birthdayが存在すれば登録できる' do
      expect(@user).to be_valid
    end

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

    it '同じemailでは登録できない' do
      @user.save
      @another_user=FactoryBot.build(:user)
      @another_user.email = @user.email
      @another_user.valid?
      expect(@another_user.errors.full_messages).to include("Email has already been taken")          
    end

    it 'emailは@を含まないと登録できない' do
      @user.email = 'kuni'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")          
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")    
    end

    it 'passwordが5文字以下では登録できない' do
      @user.password = 'abc12'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordが半角英字のみでは登録できない' do
      @user.password = '1234567'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must be a mixture of single-byte alphanumeric characters")
    end

    it 'passwordが半角数字のみでは登録できない' do
      @user.password = 'abcdefg'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must be a mixture of single-byte alphanumeric characters")
    end

    it 'passwordが全角英数字混合では登録できない' do
      @user.password = 'ａｂｃｄ１２３'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password must be a mixture of single-byte alphanumeric characters")
    end

    it 'パスワードとパスワード（確認）の値が一致しなければ登録できない' do
      @user.password = 'a1b2c3'
      @user.password_confirmation = 'a1b2d4'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end




  describe '新規登録/本人情報確認' do
    it 'お名前(全角)の名字がなければ登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")    
    end

    it 'お名前(全角)の名前がなければ登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")    
    end

    it 'お名前(全角)の名字が半角での入力であれば登録できない' do
      @user.first_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name must be entered in full-width characters")    
    end

    it 'お名前(全角)の名前が半角での入力であれば登録できない' do
      @user.last_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name must be entered in full-width characters")    
    end


    it 'お名前カナ(全角)の名字がなければ登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")    
    end

    it 'お名前カナ(全角)の名前がなければ登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")    
    end

    it 'お名前カナ(全角)の名字が半角での入力であれば登録できない' do
      @user.first_name_kana = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana must be entered in full-width characters")    
    end

    it 'お名前カナ(全角)の名前が半角での入力であれば登録できない' do
      @user.last_name_kana = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana must be entered in full-width characters")    
    end

    it '生年月日がなければ登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")    
    end
  end

  describe 'トップページ' do

  end
end
