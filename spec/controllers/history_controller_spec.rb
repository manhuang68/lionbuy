require 'rails_helper'

RSpec.describe HistoryController, type: :controller do
    before(:all) do
        @tmp = User.create(:password => "123", :email => "125@columbia.edu", :fname => "John", :lname => "Ho")
        @tmp2 = User.create(:password => "123", :email => "1299@columbia.edu", :fname => "Alexander", :lname => "Ho")
        @product = Post.create(:item => 'SAMSUNG', :description => 'Used laptop 2015 good condition', :price => '800', :user => 'AlexanderHo', :email => @tmp2.email, :category => 'Electronics', :buy_now => true, :bid => false, :start_bid => '', :current_bid => '', :closed => true)
        Post.create(:item => 'PRINTER', :description => 'Metal Platform Bed Frame with Headboard', :price => '120', :user => 'SamAlexander', :email => 'sa6156@columbia.edu', :category => 'Bedding', :buy_now => true, :bid => true, :start_bid => '100', :current_bid => '105', :closed => false)
        Post.create(:item => 'IPHONE 10', :description => 'Textbooks for freshman to senior year', :price => '10', :user => 'MikeMckenzie', :email => 'mm4111@columbia.edu', :category => 'Education', :buy_now => false, :bid => true, :start_bid => '5', :current_bid => '5', :closed => false)

        h1 = History.create({:product_id => @product.id,  :buyer_id => @tmp.id, :price => "800"})
    end

    describe 'Show sell history ' do
        it "Open sell history without signin" do
            session[:user_id] = nil
            get :sell
            expect(response).to redirect_to signin_path
        end

        it "Open sell history" do
            session[:user_id] = @tmp2.id
            get :sell
            response.should render_template :sell
        end
    end

    describe 'Show order history ' do
        it "Open order history without signin" do
            session[:user_id] = nil
            get :buy
            expect(response).to redirect_to signin_path
        end

        it "Open order history" do
            session[:user_id] = @tmp.id
            get :buy
            response.should render_template :buy
        end
    end
end
