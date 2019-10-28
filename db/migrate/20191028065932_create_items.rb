class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string      :name
      t.text        :detail
      t.string      :state
      t.string      :delivery_fee
      t.integer     :price
      t.string      :delivery_method
      t.string      :delivery_date
      t.string      :size,              default: nil
      t.integer     :favorites_count
      t.string      :brand

      t.integer     :prefecture_id
      t.integer  :buyer_id,          foreign_key: true
      t.integer  :saler_id,          foreign_key: true
      t.timestamps
    end
  end
end
