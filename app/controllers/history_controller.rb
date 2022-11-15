class HistoryController < ApplicationController
    def buy
        buyer_id = session[:user_id]
        @buy_histories = BuyHistory.where(buyer_id: buyer_id)

        (@buy_histories).each do |h|
            @current_post = Post.find_by(id: h.product_id)
            h.seller =  @current_post.user
            h.item =  @current_post.item
        end
    end

    def sell
        seller_id = session[:user_id]
        @sell_histories = SellHistory.where(seller_id: seller_id)

        (@sell_histories).each do |h|
            @current_post = Post.find_by(id: h.product_id)
            h.buyer =  @current_post.user
            h.item =  @current_post.item
        end
    end

    
end
