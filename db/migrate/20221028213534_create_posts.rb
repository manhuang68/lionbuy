class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :item
      t.text :description
      t.string :price
      t.string :user
      t.string :email
      t.string :category
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
    # add_index :posts, :post_id, :name =>'post_id'
  end

  def down
    drop_table :posts
  end
end
