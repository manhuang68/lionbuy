class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password
      t.string :email
      t.string :fname
      t.string :lname
    end
  end

  def down
    drop_table :users
  end
end
