class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :product_id
      t.string :user_id
      t.string :bid
      t.timestamps null: false
    end
  end
  def down
    drop_table :bids
  end
end
