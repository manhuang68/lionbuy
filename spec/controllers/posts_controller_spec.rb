require "rails_helper"

RSpec.describe PostsController, :type => :controller do
    before(:all) do
      @tmp = User.find_by(email: "125@columbia.edu")
      if User.where(:email => "125@columbia.edu").empty?
      @tmp =  User.create(:password => "123",:password_confirmation =>"123", :email => "125@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end
    @product_id =  Post.create(:item => 'Laptop SAMSUNG', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics', :read_seller => false, :read_buyer =>false)
      Post.create(:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding', :read_seller => false, :read_buyer =>false)
    @product2 =  Post.create(:item => 'CALCULUS Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => true, :bid => true, :start_bid => "10", :current_bid => "11", :closed => false, :read_seller => false, :read_buyer =>false)
      @product3 =  Post.create(:item => 'ALEXA DEVICE', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => true, :bid => true, :start_bid => "10", :current_bid => "10", :closed => false, :read_seller => false, :read_buyer =>false)
      Bid.create(:product_id => @product2.id , :user_id => "3"  , :bid => "11")
      @product4 = Post.create(:item => 'pencil sharpener', :description => 'Textbooks for freshman to senior year', :price => '500', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => true, :bid => true, :start_bid => "10", :current_bid => "10", :closed => true, :read_seller => false, :read_buyer =>false)
      History.create({:product_id => @product4.id,  :buyer_id => @tmp.id, :price => "500",:read_buyer => false})
    end

    describe "delete a post" do
        it "take a post and destroy" do
          session[:user_id] = "1"
          post = Post.find_by(:item =>'Queen size bed frame')
          tmp = post.id
          get :destroy, {:id => post.id}
          expect(response).to redirect_to poster_path
          expect(flash[:notice]).to match(/Post 'Queen size bed frame' deleted./)
        end
    end

    describe "updating posts" do
      it "Succeed to update the posts only buy it now" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'Laptop SAMSUNG')
        get :update, { :post => {:id => post.id, :price => "200", :start_bid => ""}}
        expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/Laptop SAMSUNG was successfully updated./)
        post.destroy
      end
      it "Succeed to update the posts only bid" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'ALEXA DEVICE')
        get :update, { :post => {:id => post.id, :price => "", :start_bid => "20"}}
        expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/ALEXA DEVICE was successfully updated./)
        post.destroy
      end
      it "Succeed to update the posts but leave the price and bid empty" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'ALEXA DEVICE')
        get :update, { :post => {:id => post.id, :price => "", :start_bid => ""}}
        expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/ALEXA DEVICE was successfully updated./)
        post.destroy
      end
    end

    describe "updating invalid posts" do
      it "Price should be greater than bid" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'ALEXA DEVICE')
        get :update, { :post => {:id => post.id, :price => "10", :start_bid => "20"}}
        #expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/Price should be greater than the bidding price./)
        post.destroy
      end
      it "Updating a post that someone bid and return failed to update" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'CALCULUS Textbooks')
        get :update, { :post => {:id => post.id, :price => "200", :start_bid => "20"}}
        #expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/You are not allowed to change the start bid when someone bid already./)
        post.destroy
      end
    end

    describe "Go to edit posts" do
      it "Enter the edit post successfully" do
        session[:user_id] = "1"
        get :edit,{:id => @product_id.id}
        response.should render_template :edit
      end
    end

    describe "Checking login status" do
      it "If the user is not logged should return to signin page" do
        session[:user_id] = nil
        get :index
        expect(response).to redirect_to signin_path
      end

    end
    describe "Valid input" do
      it "Valid input for min range and max range" do
        session[:user_id] = "1"
        session[:email] =  @product3.email
        get :index, {:min_price => "100" , :max_price => "200"}
        response.should render_template :index
      end
      it "Valid input for searching" do
        session[:user_id] = "1"
        get :index, {:keyword => "Laptop" }
        response.should render_template :index
      end
      it "Valid input for category" do
        session[:user_id] = "1"
        get :index, {:categories => {"Bedding"=>"1" }}
        response.should render_template :index
      end
    end

    describe "Invalid input" do
      it "Invalid input for min range" do
        session[:user_id] = "1"
        get :index, {:min_price => "hgf"}
        expect(flash[:notice]).to match(/Invalid price range/)
        expect(response).to redirect_to posts_path
      end
      it "Min price should be less than Max price" do
        session[:user_id] = "1"
        get :index, {:min_price => "200", :max_price => "100"}
        expect(flash[:notice]).to match(/Invalid price range/)
        expect(response).to redirect_to posts_path
      end
    end

    describe "see notification" do
      it "Click the notification" do
        session[:user_id] = nil
        session[:email] =  @product4.email
        get :read_all, xhr: true
      end
    end

    describe "Show a post" do
      it "Open a post without signin" do
        session[:user_id] = nil
        get :show, {:id => "1"}
        expect(response).to redirect_to signin_path
      end
      it "Open a post" do
        session[:user_id] = "1"
        get :show, {:id => "1"}
        response.should render_template :show
      end
      it "Showing my posts succesfully" do
        session[:user_id] = @tmp.id
        get :my_posts
        response.should render_template :my_posts
      end
      it "Showing my posts when out of session" do
        session[:user_id] = nil
        get :my_posts
        expect(response).to redirect_to signin_path
      end
      it "Showing my posts detail that I bought" do
        session[:user_id] = @tmp.id
        get :show, {:id => @product4.id }
        response.should render_template :show
      end
    end

    describe "creating new post" do
      it "Open the link to create a new post" do
        session[:user_id] = @tmp.id
        get :new
        response.should render_template :new
      end
      it "posts with buy it now and bid" do
        session[:user_id] = "1"
        get :create, {:post => {:start_bid => "20" ,:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '35', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to poster_path
        expect(flash[:notice]).to match(/Water Bottle was successfully created./)
        post = Post.find_by(item:'Water Bottle')
        post.destroy
      end
      it "posts with only buy it now" do
        session[:user_id] = "1"
        get :create, {:post => {:start_bid => "" ,:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '5', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to poster_path
        expect(flash[:notice]).to match(/Water Bottle was successfully created./)
        post = Post.find_by(item:'Water Bottle')
        post.destroy
      end
      it "posts with only auction bidding" do
        session[:user_id] = "1"
        get :create, {:post => {:start_bid => "20" ,:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to poster_path
        expect(flash[:notice]).to match(/Water Bottle was successfully created./)
        post = Post.find_by(item:'Water Bottle')
        post.destroy
      end
      it "posts with buy it now and bid but leave empty for the price" do
        session[:user_id] = "1"
        get :create, {:post => {:start_bid => "" ,:item => 'Juice Bottle', :description => 'brand new disney bottle', :price => '', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to poster_path
        expect(flash[:notice]).to match(/Juice Bottle was successfully created./)
        post = Post.find_by(item:'Juice Bottle')
        post.destroy
      end
    end

    describe "creating a invalid new post" do
      it "posts with buy it now and bid but invalid price and bidding" do
        session[:user_id] = "1"
        get :create, {:post => {:start_bid => "40" ,:item => 'Soda Bottle', :description => 'brand new disney bottle', :price => '35', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to new_post_path
        expect(flash[:notice]).to match(/Price should be greater than the bidding price./)
      end
    end
end
