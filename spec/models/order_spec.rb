require 'rails_helper'

user = FactoryBot.create(:user)

RSpec.describe Order, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        expect(order).to be_valid
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, name: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:name])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, state: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:state])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, delivery_fee: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:delivery_fee])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, price: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:price])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, delivery_method: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:delivery_method])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, delivery_date: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:delivery_date])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, state: nil, saler_id: item.saler_id, buyer_id: nil, item_id: item.id)
        order.valid?
        expect(order.errors[:buyer_id])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, state: nil, saler_id: nil, buyer_id: item.buyer_id, item_id: item.id)
        order.valid?
        expect(order.errors[:saler_id])
      end
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id, id: 1)
        order = build(:order, state: nil, saler_id: item.saler_id, buyer_id: item.buyer_id, item_id: nil)
        order.valid?
        expect(order.errors[:item_id])
      end
    end
  end
end