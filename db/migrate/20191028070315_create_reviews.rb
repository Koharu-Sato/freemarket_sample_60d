class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer     :review
      t.text        :text
      t.references  :user,   null: false, foreign_key: true

      t.timestamps
    end
  end
end
