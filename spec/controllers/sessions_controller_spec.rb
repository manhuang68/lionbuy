require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:all) do
      if User.where(:email => "125@columbia.edu").empty?
        User.create(:password => "123",:password_confirmation =>"123", :email => "125@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end

      if User.where(:email => "Anacondas").empty?
        User.create(:password => "1288", :email => "jjh@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end
  end
      describe "Login into the account" do
        it "Successfully logged" do
          get :create, {:login => {:password => "123", :email => "125@columbia.edu", :fname => "John", :lname => "Ho"}}
          #page.should have_css('h2', text: 'Welcome')
        #  page.should have_link('Log out')
          #expect(page).to have_css('h2', text: 'Welcome')
          expect(response).to redirect_to root_url
      #    get :create
      #    expect(response.body).to match /<h2>.*Welcome/im
          #User.find_by(:email => "125@columbia.edu").destroy
        end
        it "warns the user if the email does not exist" do
          get :create, {:login => {:password => "", :email => "987644@columbia.edu"}}
          #pending response
          expect(response).to redirect_to signin_path
          expect(flash[:notice]).to match('Password cannot be empty!')
          #User.find_by(:email => "125@columbia.edu").destroy
        end
        it "warns the user if the email does not exist" do
          get :create, {:login => {:password => "123", :email => ""}}
          expect(response).to redirect_to signin_path
          expect(flash[:notice]).to match('Email cannot be empty!')
        end
        it "warns the user if the email does not exist" do
          get :create, {:login => {:password => "123", :email => "987644@columbia.edu"}}
          #pending response
          expect(response).to redirect_to signin_path
          expect(flash[:notice]).to match('Account does not exist!')
          #User.find_by(:email => "125@columbia.edu").destroy
        end
        it "warns the user if the password is wrong" do
          get :create, {:login => {:password => "123456", :email => "125@columbia.edu"}}
          #pending response
          expect(response).to redirect_to signin_path
          expect(flash[:notice]).to match('Invalid credentials!')
          #User.find_by(:email => "125@columbia.edu").destroy
        end
     end
end
