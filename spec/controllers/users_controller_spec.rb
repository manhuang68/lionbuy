require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before(:all) do
      if User.where(:email => "125@columbia.edu").empty?
        User.create(:password => "123",:password_confirmation =>"123", :email => "125@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end

      if User.where(:email => "Anacondas").empty?
        User.create(:password => "1288", :email => "jjh@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end
  end
      describe "Registering a new account" do
        it "create a new account" do
          get :create, {:user => {:password => "123",:password_confirmation =>"123", :email => "hello@columbia.edu", :fname => "John", :lname => "Ho"}}
          #pending response
          expect(response).to redirect_to root_url
          expect(flash[:notice]).to match(/Account registered successfully!/)
          #User.find_by(:email => "125@columbia.edu").destroy
        end
       it "warns the user if the email is already registered" do
         get :create, {:user => {:password => "123", :email => "125@columbia.edu", :fname => "hello", :lname => "hi"}}
         #pending response
         expect(response).to redirect_to signup_path
         expect(flash[:notice]).to match(/Email already exist!/)
         #User.find_by(:email => "125@columbia.edu").destroy
       end
     end
  end
