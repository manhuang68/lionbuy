class BidsController < ApplicationController

  def history
    @record = Bid.sorting(params[:id])
    @item = Post.find_by(id: params[:id])
  end

  def create
    @bidding = Bid.all
    @bidding.each do |b|
      puts b.user_id
      puts b.product_id
      puts b.bid
    end
    #@bidding_historydd = Bid.find_by(id: 2)
    #puts "dfds"
    #puts @bidding_historydd.created_at
    @bidding_history = Bid.find_by(product_id: bid_params[:product_id])
    @current_post = Post.find_by(id: bid_params[:product_id])
    @current_bid = @current_post.current_bid
    parameter = bid_params
    parameter[:user_id] = session[:user_id]
  #  puts parameter
    if @bidding_history == nil
      if bid_params[:bid].to_f >= @current_bid.to_f
        Bid.create(parameter)
        @post = Post.find_by(id: bid_params[:product_id])
        @post.update_attribute(:current_bid , bid_params[:bid])
        flash[:notice] = 'You placed a bid of '+bid_params[:bid]
        redirect_to posts_path and return
      else
        flash[:notice] = 'The Bid amount must be equal or greater than '+@current_bid
        redirect_to posts_path and return
      end
    else
      if bid_params[:bid].to_f > @current_bid.to_f
        flash[:notice] = 'You placed a bid of '+bid_params[:bid]
        Bid.create(parameter)
        @post = Post.find_by(id: bid_params[:product_id])
        @post.update_attribute(:current_bid , bid_params[:bid])

        @sorted = Bid.sorting(bid_params[:product_id])
        puts "the sorted are"
        @sorted.each do |b|
          puts "id is"
          puts b.user_id
          puts "product id is"
          puts b.product_id
          puts "bid is"
          puts b.bid
          puts b.created_at
        #  puts b.timestamps
        end
        redirect_to posts_path and return
      else
        flash[:notice] = 'The Bid amount must be equal or greater than '+@current_bid
        @sorted = Bid.sorting(bid_params[:product_id])
        redirect_to posts_path and return
      end
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:bid, :product_id, :id)
  end
end
