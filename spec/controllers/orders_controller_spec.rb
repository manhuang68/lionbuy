require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before(:all) do
      #User.delete_all
      Post.delete_all
      if User.where(:email => "125@columbia.edu").empty?
        User.create(:password => "123",:password_confirmation =>"123", :email => "125@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end

      if User.where(:email => "mm4111@columbia.edu").empty?
        User.create(:password => "1288", :email => "mm4111@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end
      @post = nil
      if Post.where(:item => "IBM laptop").empty?
        @post = Post.create(:item => 'IBM laptop', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding', :buy_now => true, :bid => true, :start_bid => '100', :current_bid => '105', :closed => false)
        Bid.create(:product_id => @post.id,  :user_id => "1", :bid => "105")
      end

      @post2 = nil
      if Post.where(:item => "Headphones").empty?
      @post2 =  Post.create(:item => 'Headphones', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => false, :bid => true, :start_bid => '5', :current_bid => '5', :closed => false)
      end
  end

  describe "Buy and Item" do
    it "Buying my own item and returns invalid" do
      session[:user_id] = "1"
      session[:email] = "mm4111@columbia.edu"
      get :create, {:order => {:product_id => @post2.id}}
      expect(response).to redirect_to redirect_to post_path(@post2)
      expect(flash[:warning]).to match('You are not allowed to buy your own item')
    end
    it "Buying an IBM laptop and return successfully" do
      session[:user_id] = "1"
      session[:email] = nil
      get :create, {:order => {:product_id => @post2.id}}
      expect(response).to redirect_to order_history_path
      expect(flash[:notice]).to match('Your order for Headphones has been placed!')
    end
  end

  describe "Accept a deal for a bid" do
    it "Accept the deal for an IBM laptop and return successfully" do
      session[:user_id] = "1"
      get :accept_bid, {:order => {:product_id => @post.id}}
      expect(response).to redirect_to selling_history_path
      expect(flash[:notice]).to match('You accepted the deal for IBM laptop !')
    end
  end
end
