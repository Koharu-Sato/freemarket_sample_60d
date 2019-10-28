require 'rails_helper'

RSpec.describe Image, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
end

RSpec.describe Image, type: :model do
  describe '#create' do
    context '画像がnull,画像が保存されるか?' do
      it 'is valid with image' do #Imageが存在していたら出品できる
        # item = FactoryBot.create(:item)
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, saler_id: user.id)
        image = build(:image, item_id: item.id)
        expect(image).to be_valid
      end
      it 'is valid without image' do  ##imageがなくても保存されてるー
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, saler_id: user.id)
        image = build(:image, id: 1, image: nil, item_id: item.id)
        image.valid?
        expect(image.errors[:image]).to include("画像がありません")
      end
    end
  end
end

