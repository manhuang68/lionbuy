class CreateBuyHistories < ActiveRecord::Migration
  def change
    create_table :buy_histories do |t|
      t.string :product_id
      t.string :buyer_id
      t.string :price

      t.timestamps null: false
    end
  end
end
