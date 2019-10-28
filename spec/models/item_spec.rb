require 'rails_helper'

user = FactoryBot.create(:user)

RSpec.describe Item, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with item' do #Itemが存在していたら出品できる
        item = build(:item, saler_id: user.id)
        expect(item).to be_valid
      end
      it 'is valid without item' do #name,nil
        item = build(:item, name: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:name]).to include("入力してください")
      end
      it 'nameが40文字以上でvalid' do
        item = build(:item, name: "a" * 41, saler_id: user.id)
        item.valid?
        expect(item.errors[:name]).to include("40 文字以下で入力してください")
      end
      it 'is valid without item' do #detail,nil
        item = build(:item, detail: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:detail]).to include("入力してください")
      end
      it 'detailが1000文字以上でvalid' do
        item = build(:item, detail: "a" * 1001, saler_id: user.id)
        item.valid?
        expect(item.errors[:detail]).to include("1000 文字以下で入力してください")
      end
      it 'is valid without item' do 
        item = build(:item, state: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:state]).to include("入力してください")
      end
      it 'is valid without item' do 
        item = build(:item, delivery_fee: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:delivery_fee]).to include("選択してください")
      end
      it 'is valid without item' do
        item = build(:item, delivery_method: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:delivery_method]).to include("選択してください")
      end
      it 'is valid without item' do 
        item = build(:item, delivery_date: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:delivery_date]).to include("選択してください")
      end
      it 'is valid without item' do 
        item = build(:item, size: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:size]).to include("選択してください")
      end
      it 'is valid without item' do
        item = build(:item, price: nil, saler_id: user.id)
        item.valid?
        expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
      end
      it 'priceが300円以下でvalid' do
        item = build(:item, price: 200, saler_id: user.id)
        item.valid?
        expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
      end
      it 'priceが9,999,999円以上ででvalid' do
        item = build(:item, price: 10000000, saler_id: user.id)
        item.valid?
        expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
      end
    end
  end
end