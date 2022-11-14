class CreateSellHistories < ActiveRecord::Migration
  def change
    create_table :sell_histories do |t|
      t.string :product_id
      t.string :seller_id
      t.string :price
      t.timestamps null: false
    end
  end
end
