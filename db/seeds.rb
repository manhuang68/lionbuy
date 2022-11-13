# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

posts = [{:item => 'Laptop MAC', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics', :buy_now => true, :bid => false, :start_bid => "", :current_bid => ""},
		 {:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding', :buy_now => true, :bid => true, :start_bid => "100", :current_bid => "105"},
		 {:item => 'Chemical Engineering Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => false, :bid => true, :start_bid => "5", :current_bid => "5"},
		 {:item => 'Air Purifier', :description => 'Brand new. Morningside campus only.', :price => '15', :user => 'ShuyuWang', :email => 'sw4231@columbia.edu', :category => 'Electronics',:buy_now => false, :bid => true, :start_bid => "10", :current_bid => "10"},
		 {:item => 'Desk Lamp', :description => '3 brightness levels, light bulb included', :price => '25', :user => 'JenniferLee', :email => 'jl4152@columbia.edu', :category => 'Electronics', :buy_now => true, :bid => true, :start_bid => "15", :current_bid => "15"},
		]

posts.each do |post|
  Post.create!(post)
end

users = [{:email => '123@columbia.edu', :password=> '123',:fname =>'John', :lname=> 'Ho' }]

users.each do |user|
  User.create!(user)
end

bids = [{:product_id => "2",  :user_id => "1", :bid => "105"}]

bids.each do |bid|
	Bid.create!(bid)
end
