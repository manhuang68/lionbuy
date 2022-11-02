require "rails_helper"

RSpec.describe PostsController, :type => :controller do
    before(:all) do
      User.create(:password => "123", :email => "125@columbia.edu", :fname => "John", :lname => "Ho")
      #get :create, {:login => {:password => "123", :email => "125@columbia.edu"}}
      #Sessions.create()
      Post.create(:item => 'Laptop MAC', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics')
      Post.create(:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding')
      Post.create(:item => 'Chemical Engineering Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education')
    end

    describe "delete a post" do
        it "take a post and destroy" do
          session[:user_id] = "1"
          post = Post.find_by(:item =>'Laptop MAC')
          tmp = post.id
          get :destroy, {:id => post.id}
          expect(response).to redirect_to posts_path
          expect(flash[:notice]).to match(/Post 'Laptop MAC' deleted./)
        end
    end

    describe "creating new post" do
      it "posts with valid parameters" do
        session[:user_id] = "1"
        get :create, {:post => {:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '5', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to posts_path
        expect(flash[:notice]).to match(/Water Bottle was successfully created./)
        post = Post.find_by(item:'Water Bottle')
        post.destroy
      end
    end

    describe "updating posts" do
      it "checking posts" do
        session[:user_id] = "1"
        post = Post.find_by(:item =>'Chemical Engineering Textbooks')
        get :update, {:id => post.id, :post =>{:category => "Book"}}
        expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/Chemical Engineering Textbooks was successfully updated./)
        post.destroy
      end
    end

end
