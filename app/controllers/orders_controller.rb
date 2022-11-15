class OrdersController < ApplicationController

  def create
    if session[:user_id] == nil
      redirect_to "/signin" and return
    end
    @post = Post.find_by(id: order_params[:product_id])
    #save buying history
    ordering = {:product_id => @post.id,  :buyer_id => session[:user_id], :price => @post.price}
    BuyHistory.create!(ordering)

    #save selling history
    @seller = User.find_by(email: @post.email)
    selling = {:product_id => @post.id,  :seller_id => @seller.id, :price => @post.price}
    SellHistory.create!(selling)
    @post.update_attribute(:closed, true)
    flash[:notice] = "Your order for "+ @post.item + " has been placed!"
    redirect_to order_history_path
  end

  def update
#    @post = Post.find_by(id: params[:id])
#    @post.update_attribute(:closed, false)
  end

  def bidding

  end

  private
  def order_params
    params.require(:order).permit(:product_id)
  end
end
