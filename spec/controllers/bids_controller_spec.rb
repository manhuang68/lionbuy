require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  before(:all) do
    User.create(:password => "123", :email => "125@columbia.edu", :fname => "John", :lname => "Ho")
    #get :create, {:login => {:password => "123", :email => "125@columbia.edu"}}
    #Sessions.create()
    Post.create(:item => 'Laptop MAC BOOK', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics', :buy_now => true, :bid => false, :start_bid => '', :current_bid => '')
    Post.create(:item => 'Queen size bed frameswork', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding', :buy_now => true, :bid => true, :start_bid => '100', :current_bid => '105')
    Post.create(:item => 'Math Engineering Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => false, :bid => true, :start_bid => '5', :current_bid => '5')
      @posting = Post.find_by(item: 'Queen size bed frameswork')
    Bid.create(:product_id => @posting.id,  :user_id => "1", :bid => "105")
  end

  describe "Render a bid history" do
    it "View Bidding history for user 1" do
      session[:user_id] = 1
      session[:fname] = "John"
      session[:lname] = "Ho"
      #expect(response).to redirect_to root_url
      @post = Post.find_by(:item =>'Laptop MAC')
      puts @post.id
    #  get :update, {:id => movie.id, assert_redirected_to
      get :history, {:id => @post.id}
      response.should render_template :history
    end
  end

  describe "Bidding with a invalid number" do
    it "Make a invalid bid for the first time in a post" do
      session[:user_id] = 1
      session[:fname] = "John"
      session[:lname] = "Ho"
      @post = Post.find_by(item: 'Math Engineering Textbooks')
      get :create, {:bid => {:product_id => @post.id,:bid=>"2"}}
    #  @post = Post.find_by(id: "3")
      puts "the bid id "
      puts @post.bid
      puts @post.item
      expect(response).to redirect_to post_path(@post)
      expect(flash[:notice]).to match("The Bid amount must be equal or greater than $5")
    end
    it "Make a bid into an existing post bidding" do
      session[:user_id] = 1
      session[:fname] = "John"
      session[:lname] = "Ho"
      @post = Post.find_by(item: 'Queen size bed frameswork')
      get :create, {:bid => {:product_id => @post.id,:bid=>"100"}}
      expect(response).to redirect_to post_path(@post)
      expect(flash[:notice]).to match("The Bid amount must be greater than $105")
    end
  end

  describe "Bidding with a valid number" do
    it "Make a bid for the first time in a post" do
      session[:user_id] = 1
      session[:fname] = "John"
      session[:lname] = "Ho"
      @post = Post.find_by(item: 'Math Engineering Textbooks')
      get :create, {:bid => {:product_id =>@post.id,:bid=>"12"}}
      expect(response).to redirect_to post_path(@post)
      expect(flash[:notice]).to match("You placed a bid of $12")
    end
    it "Make a bid into an existing post bidding" do
      session[:user_id] = 1
      session[:fname] = "John"
      session[:lname] = "Ho"
      @post = Post.find_by(item: 'Queen size bed frameswork')
      get :create, {:bid => {:product_id => @post.id,:bid=>"120"}}
      expect(response).to redirect_to post_path(@post)
      expect(flash[:notice]).to match("You placed a bid of $120")
    end
  end



end
