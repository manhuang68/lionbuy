require 'rails_helper'

RSpec.describe HistoryController, type: :controller do
    before(:all) do
        h1 = History.create({:product_id => "1",  :buyer_id => "1", :price => "800"})
    end

    describe 'Show sell history ' do
        it "Open sell history without signin" do
            session[:user_id] = nil
            get :sell
            expect(response).to redirect_to signin_path
        end

        it "Open sell history" do
            session[:user_id] = "3" 
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
            session[:user_id] = "1"
            get :buy
            response.should render_template :buy
        end
    end
end
