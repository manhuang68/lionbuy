class HistoryController < ApplicationController
    def buy
        if session[:user_id] == nil
            redirect_to "/signin" and return
        end

        buyer_id = session[:user_id]
        @buy_histories = History.where(buyer_id: buyer_id)

        (@buy_histories).each do |h|
            @current_post = Post.find_by(id: h.product_id)
            h.seller =  @current_post.user
            h.item =  @current_post.item
        end
    end

    def sell
        if session[:user_id] == nil
            redirect_to "/signin" and return
        end

        # byebug
        seller_id = session[:user_id]
        seller_email = User.find_by(id:seller_id).email
        @posts = Post.where(email: seller_email)

        @sell_histories = []


        (@posts).each do |p|
            if !p.closed
                next
            end
            # byebug

            his = History.find_by(product_id: p.id)
            if his != nil
                buyer = User.find_by(id: his.buyer_id)
                his.buyer = buyer.fname + buyer.lname
                his.item =  p.item
                @sell_histories.append(his)
            end
        end
    end

end
