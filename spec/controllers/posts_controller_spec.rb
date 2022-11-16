require "rails_helper"

RSpec.describe PostsController, :type => :controller do
    before(:all) do
      User.create(:password => "123", :email => "125@columbia.edu", :fname => "John", :lname => "Ho")
      Post.create(:item => 'Laptop MAC', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics')
      Post.create(:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding')
      Post.create(:item => 'Chemical Engineering Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education')
    end

    describe "delete a post" do
      it "Failed to delete the post due to out of session" do
        session[:user_id] = nil
        post = Post.find_by(:item =>'Laptop MAC')
        tmp = post.id
        get :destroy, {:id => post.id}
        expect(response).to redirect_to signin_path
      end
  end

    describe "delete a post" do
        it "take a post and destroy" do
          session[:user_id] = "1"
          post = Post.find_by(:item =>'Laptop MAC')
          tmp = post.id
          get :destroy, {:id => post.id}
          expect(response).to redirect_to my_posts_path
          expect(flash[:notice]).to match(/Post 'Laptop MAC' deleted./)
        end
    end


    describe "creating new post" do
      it "posts with valid parameters" do
        session[:user_id] = "1"
        get :create, {:post => {:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '5', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to my_posts_path
        expect(flash[:notice]).to match(/Water Bottle was successfully created./)
        post = Post.find_by(item:'Water Bottle')
        post.destroy
      end
      it "Failed to create the post due to out of session" do
        session[:user_id] = nil
        get :create, {:post => {:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '5', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to signin_path
      end
    end

    describe "updating posts" do
      it "Succeed to update the posts" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'Chemical Engineering Textbooks')
        get :update, {:id => post.id, :post =>{:category => "Book"}}
        expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/Chemical Engineering Textbooks was successfully updated./)
        post.destroy
      end

    end
    describe "updating posts" do
      it "Failed to update the post due to out of session" do
        session[:user_id] = nil
        post = Post.find_by(:item =>'Chemical Engineering Textbooks')
        get :update, {:id => post.id, :post =>{:category => "Book"}}
        expect(response).to redirect_to signin_path
      end
    end

    describe "Editing posts" do
      it "Editing the post" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'Chemical Engineering Textbooks')
        get :edit, {:id => post.id, :post =>{:category => "Book"}}
        post.destroy
      end
    end

    describe "Editing posts" do
      it "Session expired" do
        session[:user_id] = nil
        post = Post.find_by(:item =>'Chemical Engineering Textbooks')
        get :edit, {:id => post.id, :post =>{:category => "Book"}}
        expect(response).to redirect_to signin_path
        post.destroy
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
    end



end
