FactoryBot.define do
  factory :order do
    name { "名前" }
    detail { "主催者の名前" }
    state { "参加条件" }
    delivery_fee { "参加条件" }
    delivery_method { "参加条件" }
    price { 1000 }
    delivery_date { "参加条件" }
    buyer_id { 1 }
    saler_id { 1 }
    item_id { 1 }
  end
end