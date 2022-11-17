require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
			Post.delete_all
			@posting = [{:item => 'Laptop MAC', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics'},
					 {:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding'},
					 {:item => 'Chemical Engineering Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education'},
					 {:item => 'Air conditioner portable', :description => 'Brand new. Morningside campus only.', :price => '15', :user => 'ShuyuWang', :email => 'sw4231@columbia.edu', :category => 'Electronics'},
					 {:item => 'Microphone computer', :description => '3 brightness levels, light bulb included', :price => '25', :user => 'JenniferLee', :email => 'jl4152@columbia.edu', :category => 'Electronics'},
					]
					@posting.each do |post|
					  Post.create!(post)
					end
					@post3 = Post.find_by(item: 'Air conditioner portable')
					@post4 = Post.find_by(item: 'Microphone computer')
					puts " thi etme 1"
					puts @post3.item
					puts "the item 2"
					puts @post4.item


  		end

			  describe 'check category' do
			    it "takes a post and returns its category" do
			      @post = Post.find_by(item: 'Laptop MAC')
			      expect(@post.category).to eq('Electronics')
			    end
			  end

			  describe 'check post name' do
			    it "takes a post and returns its post name" do
			      @post = Post.find_by(item: 'Laptop MAC')
			      expect(@post.item).to eq('Laptop MAC')
			    end
					it "Check if contains an item" do
						@post = Post.find_by(item: 'Laptop MAC')
						expect(@post.with_keyword('MAC')).to eq(true)
					end
			  end

			  describe 'check post description' do
			    it "takes a post and returns its post description" do
			      @post = Post.find_by(item: 'Laptop MAC')
			      expect(@post.description).to eq('Used laptop 2015 good condition')
			    end
			  end

			  describe 'check item price' do
			    it "takes a post and returns its item price" do
			      @post = Post.find_by(item: 'Laptop MAC')
			      expect(@post.price).to eq('800')
			    end
			  end

			  describe 'check item seller' do
			    it "takes a post and returns its item seller and email" do
			      @post = Post.find_by(item: 'Laptop MAC')
			      expect(@post.user).to eq('JohnHarrison')
			      expect(@post.email).to eq('jh4142@columbia.edu')
			    end
			  end

			  describe 'not has a category' do
			    it "takes a post and returns nil" do
			      Post.create(:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '5', :user => 'KevinWang', :email => 'kw1252@columbia.edu')
			      @post =Post.find_by(item: 'Water Bottle')
			      expect(@post.category).to be_nil
			      @post.destroy
			    end

			  end

				  describe 'two posts share same category' do
				    it "takes two posts and assert equality" do
				      @post1 = Post.find_by(item: 'Air conditioner portable')
				      @post2 = Post.find_by(item: 'Microphone computer')
							puts " thi etme 1"
							puts @post1.item
							puts "the item 2"
							puts @post2.item

				      expect(@post1.category).to eq(@post2.category)
				    end
					end

end
