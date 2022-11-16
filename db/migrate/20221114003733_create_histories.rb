class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :product_id
      t.string :buyer_id
      t.string :price

      t.timestamps null: false
    end
  end
end
