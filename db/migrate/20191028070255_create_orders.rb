class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string      :name
      t.text        :detail
      t.string      :state
      t.string      :delivery_fee
      t.integer     :price
      t.string      :delivery_method
      t.string      :delivery_date 

      t.integer  :buyer_id, foreign_key: true
      t.integer  :saler_id, foreign_key: true
      t.references  :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end