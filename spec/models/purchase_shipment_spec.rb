require 'rails_helper'

RSpec.describe PurchaseShipment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shipment = FactoryBot.build(:purchase_shipment, user_id: user.id, item_id: item.id)
    sleep 1
  end

  describe '商品購入機能' do
    context '商品購入ができるとき' do
      it '全て入力済みであれば登録できる' do
        expect(@purchase_shipment).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @purchase_shipment.building = ''
        expect(@purchase_shipment).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_shipment.postal_code = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_shipment.postal_code = '1234567'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Postal code Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'postal_codeが全角文字だと保存できないこと' do
        @purchase_shipment.postal_code = '１２３−５６７８'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Postal code Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_shipment.prefecture_id = '1'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Prefecture can't be blank")
      end


      it 'municipalityが空だと保存できないこと' do
        @purchase_shipment.municipality = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Municipality can't be blank")
      end


      it 'addressが空だと保存できないこと' do
        @purchase_shipment.address = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Address can't be blank")
      end


      it 'telが空だと保存できないこと' do
        @purchase_shipment.tel = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Tel can't be blank")
      end

      it 'telが整数以外であれば保存できないこと' do
        @purchase_shipment.tel = 'ああああ'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Tel is not a number")
      end

      it 'telが10桁以下であれば保存できないこと' do
        @purchase_shipment.tel = '111'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Tel is too short (minimum is 10 characters)")
      end

      it 'tokenが空だと保存できないこと' do
        @purchase_shipment.token = ''
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Token can't be blank")
      end


      it 'userが紐付いていないと保存できないこと' do
        @purchase_shipment.user_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("User can't be blank")
      end


      it 'itemが紐付いていないと保存できないこと' do
        @purchase_shipment.item_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Item can't be blank")
      end
    end
      
  end


end
