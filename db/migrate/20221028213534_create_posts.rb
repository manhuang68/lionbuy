class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :item
      t.text :description
      t.string :user
      t.string :email
      t.string :category
      # Add fields that let Rails automatically keep track
      #bid:
      t.boolean :bid
      t.string :start_bid
      t.string :current_bid
      #price
      t.boolean :buy_now
      t.string :price
      # of when movies are added or modified:
      t.timestamps
    end
    # add_index :posts, :post_id, :name =>'post_id'
  end

  def down
    drop_table :posts
  end
end
