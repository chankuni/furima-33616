require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品ができるとき' do
      it '全て入力済みであれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it '商品画像がなければ登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がなければ登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明がなければ登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報がなければ登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it ' 商品の状態の情報がなければ登録できない' do
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it ' 配送料の負担の情報がなければ登録できない' do
        @item.charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge can't be blank")
      end

      it ' 発送元の地域の情報がなければ登録できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it ' 発送までの日数の情報がなければ登録できない' do
        @item.duration_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Duration can't be blank")
      end

      it ' 価格の情報がなければ登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it ' 価格の情報が全角数字であれば登録できない' do
        @item.price = '１２３'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it ' 価格の情報が300未満であれば登録できない' do
        @item.price = 123
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it ' 価格の情報が10000000以上であれば登録できない' do
        @item.price = 6_666_666_666_666_666_666
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it ' ユーザーが紐づいてなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
