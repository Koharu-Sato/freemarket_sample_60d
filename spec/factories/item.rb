FactoryBot.define do
  factory :item do
    name { "名前" }
    detail { "主催者の名前" }
    state { "参加条件" }
    size { "参加条件" }
    delivery_fee { "参加条件" }
    delivery_method { "参加条件" }
    price { 1000 }
    delivery_date { "参加条件" }
    prefecture_id { 1 }
    saler_id { 1 }
    buyer_id { 1 }
  end
end
