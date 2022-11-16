class HistoryController < ApplicationController
    def buy
        buyer_id = session[:user_id]
        @buy_histories = History.where(buyer_id: buyer_id)

        (@buy_histories).each do |h|
            @current_post = Post.find_by(id: h.product_id)
            h.seller =  @current_post.user
            h.item =  @current_post.item
        end
    end

    def sell
        seller_id = session[:user_id]
        seller_email = User.find_by(id:seller_id).email
        @posts = Post.where(email: seller_email)

        @sell_histories = []
        (@posts).each do |p|
            h = History.find_by(product_id: p.id)
            buyer = User.find_by(id: h.buyer_id)
            h.buyer = buyer.fname + buyer.lname
            h.item =  p.item
            @sell_histories.append(h)
        end
    end
    
end
