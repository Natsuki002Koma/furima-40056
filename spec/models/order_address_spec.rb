require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it 'すべての項目に正しく入力すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'buildingが空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品購入できない場合' do
      it 'post_codeが空では登録できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが「3桁ハイフン4桁」以外では登録できない' do
        @order_address.post_code = '1111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'post_codeが半角文字列以外では登録できない' do
        @order_address.post_code = '１１０－００１１'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefecture_idが空では登録できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが初期値（---）では登録できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'streetが空では登録できない' do
        @order_address.street = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street can't be blank")
      end
      it 'telが空では登録できない' do
        @order_address.tel = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel can't be blank")
      end
      it 'telが10桁未満では登録できない' do
        @order_address.tel = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is too short (minimum is 10 characters)')
      end
      it 'telが12桁以上では登録できない' do
        @order_address.tel = '012345678912'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is too long (maximum is 11 characters)')
      end
      it 'telに半角数値以外の文字が含まれる場合は登録できない' do
        @order_address.tel = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tel is invalid. Input only number')
      end
      it 'itemに紐づいていなければ登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'userに紐づいていなければ登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
