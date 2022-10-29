# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
    	  {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984'},
    	  {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989'},
      	  {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011'},
      	  {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
      	  {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
      	  {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
      	  {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
      	  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
      	  {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
					{:title => 'Star Wars', :rating => 'PG', :release_date => '25-May-1977'},
					{:title => 'Alien', :rating => 'R', :release_date => '25-May-1979'},
  	 ]

movies.each do |movie|
  Movie.create!(movie)
end

posts = [{:item => 'Laptop MAC', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu'},
		 {:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu'},
		 {:item => 'Chemical Engineering Textbooks', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu'},
		 {:item => 'Air Purifier', :description => 'Brand new. Morningside campus only.', :price => '15', :user => 'ShuyuWang', :email => 'sw4231@columbia.edu'},
		 {:item => 'Desk Lamp', :description => '3 brightness levels, light bulb included', :price => '25', :user => 'JenniferLee', :email => 'jl4152@columbia.edu'},
		]

posts.each do |post|
  Post.create!(post)
end

users = [{:email => '123@columbia.com', :password=> '123' }]

users.each do |user|
  User.create!(user)
end
