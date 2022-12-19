class OrdersController < ApplicationController

  def create
    if session[:user_id] != nil
      #  redirect_to "/signin" and return
      #end
      @post = Post.find_by(id: order_params[:product_id])

      @price = order_params[:price]
      #byebug
      #save buying history
      if @post.email == session[:email]
        flash[:warning] = 'You are not allowed to buy your own item'
        redirect_to post_path(@post) and return
      end

      ordering = {:product_id => @post.id,  :buyer_id => session[:user_id], :price => @price, :read_buyer => true}
      History.create!(ordering)

      #save selling history
      # @seller = User.find_by(email: @post.email)
      # selling = {:product_id => @post.id,  :seller_id => @seller.id, :price => @post.price}
      # SellHistory.create!(selling)
      @post.update_attribute(:closed, true)
      @post.update_attribute(:read_buyer, false)

      flash[:notice] = "Your order for "+ @post.item + " has been placed!"
      redirect_to order_history_path
    end
  end

  def accept_bid
    if session[:user_id] != nil
      #  redirect_to "/signin" and return
      #end
      @post = Post.find_by(id: order_params[:product_id])
      @sorted = Bid.sorting(order_params[:product_id])
      puts @sorted[0]

      ordering = {:product_id => @sorted[0].product_id, :buyer_id => @sorted[0].user_id, :price => @sorted[0].bid, :read_buyer => false}
      History.create!(ordering)
      puts ordering

      @post.update_attribute(:closed, true)
      #@post.update_attribute(:read_buyer, false)


      flash[:notice] = "You accepted the deal for "+ @post.item + " !"
      redirect_to selling_history_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:product_id, :price)
  end
end
