class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string        :postal_code
      t.string        :city
      t.string        :block
      t.string        :building
      t.integer       :tel

      t.integer       :prefecture_id
      t.references    :user,               null: false, foreign_key: true

      
      t.timestamps
    end
  end
end