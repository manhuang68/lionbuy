require "rails_helper"

RSpec.describe PostsController, :type => :controller do
    before(:all) do
      Post.create(:item => 'Laptop MAC', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'JohnHarrison', :email => 'jh4142@columbia.edu', :category => 'Electronics')
      Post.create(:item => 'Queen size bed frame', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding')
      Post.create(:item => 'Chemical Engineering Textbooks', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education')
    end

    describe "delete a post" do
        it "take a post and destroy" do
          post = Post.find_by(:item =>'Laptop MAC')
          get :destroy, {:id => post.id}
          expect(response).to redirect_to post_path(post)
          expect(flash[:notice]).to match(/Post 'Laptop MAC' deleted./)
        end
    end

    describe "creating new post" do
      it "posts with valid parameters" do
        get :create, {:post => {:item => 'Water Bottle', :description => 'brand new disney bottle', :price => '5', :user => 'KevinWang', :email => 'kw1252@columbia.edu'}}
        expect(response).to redirect_to posts_path
        expect(flash[:notice]).to match(/Post 'Water Bottle' was successfully created./)
        post = Post.find_by(item:'Water Bottle')
        post.destroy
      end
    end

    describe "updating posts" do
      it "checking posts" do
        post = Post.find_by(:item =>'Chemical Engineering Textbooks')
        get :update, {:id => post.id, :post =>{:category => "Book"}}
        expect(response).to redirect_to post_path(post)
        expect(flash[:notice]).to match(/Post 'Chemical Engineering Textbooks' was successfully updated./)
        post.destroy
      end
    end

end