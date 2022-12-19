class BidsController < ApplicationController

  def history
    puts "the name is"
    puts session[:fname]
    @record = Bid.sorting(params[:id])
    @item = Post.find_by(id: params[:id])
    puts @record[0]
    puts "you are the higher"
  end

  def create
    @bidding_history = Bid.find_by(product_id: bid_params[:product_id])
    @current_post = Post.find_by(id: bid_params[:product_id])
    @current_bid = @current_post.current_bid
    parameter = bid_params
    parameter[:user_id] = session[:user_id]

    if @current_post.email == session[:email]
      flash[:warning] = 'You are not allowed to bid your own item'
      redirect_to post_path(@current_post) and return
    end
    # puts parameter
    # puts "bid : " + bid_params[:bid]
    # puts "current bid : "
    # puts @current_bid
    if @bidding_history == nil
      if bid_params[:bid].to_f >= @current_bid.to_f
        Bid.create(parameter)
        @post = Post.find_by(id: bid_params[:product_id])
        @post.update_attribute(:current_bid , bid_params[:bid])
        @post.update_attribute(:read_seller, false)
        flash[:notice] = 'You placed a bid of $'+bid_params[:bid]
        redirect_to post_path(@post) and return
      else
        flash[:notice] = 'The Bid amount must be equal or greater than $'+@current_bid
        redirect_to post_path(@current_post) and return
      end
    else
      if bid_params[:bid].to_f > @current_bid.to_f
        flash[:notice] = 'You placed a bid of $'+bid_params[:bid]
        Bid.create(parameter)
        @post = Post.find_by(id: bid_params[:product_id])
        @post.update_attribute(:current_bid , bid_params[:bid])
        @post.update_attribute(:read_seller, false)
        @sorted = Bid.sorting(bid_params[:product_id])
        redirect_to post_path(@post) and return
      else
        flash[:notice] = 'The Bid amount must be greater than $'+@current_bid
        @sorted = Bid.sorting(bid_params[:product_id])
        redirect_to post_path(@current_post) and return
      end
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:bid, :product_id, :id)
  end
end
