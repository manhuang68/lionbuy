require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before(:all) do
      User.delete_all
      if User.where(:email => "125@columbia.edu").empty?
        User.create(:password => "123",:password_confirmation =>"123", :email => "125@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end

      if User.where(:email => "Anacondas").empty?
        User.create(:password => "1288", :email => "jjh@columbia.edu", :fname => "PG", :lname => "gfhhfh")
      end
  end

end
