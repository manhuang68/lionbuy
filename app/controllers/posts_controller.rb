class PostsController < ApplicationController

  def show
    if session[:user_id] == nil
      redirect_to signin_path and return
    end
    @item = Post.find_by(id: params[:id])
    @history = History.find_by(product_id: params[:id])
    @buyer = nil
    if @history != nil
      @buyer = User.find_by(id: @history.buyer_id)
    end
  end

  def ajaxtest
    puts "this is ajaxtest"
    respond_to do |format|
      format.js
      format.html
    end
  end
  # method to lable all notifications as read
  def read_all
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to signin_path and return
    end
    @notification = nil
    #session[:notification] = nil
    if session[:unread_posts] != nil
      if session[:unread_posts].length() != 0
        @notification = session[:unread_posts].clone
        puts "the nottificaiton "
        #puts @notification.read_seller
      end

      session[:unread_posts].each do |p|
        if p.email == session[:email]
          p.update_attribute(:read_seller, true)
        else
          p.update_attribute(:read_buyer, true)
        end
      end

    end
    session[:unread_posts] = nil

    respond_to do |format|
      format.js
      format.html
    end
  end

  def index
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to signin_path and return
    end

    # Call it every time log in
    user_id = session[:user_id]
    user = User.find_by(id:user_id)
    user_email = user.email
    @unread_posts = Post.where(email:user_email, read_seller:false) | Post.where(email:user_email, read_buyer:false)
    # @unread_posts = Array(Post.find_by(id:1))

    session[:unread_posts] = @unread_posts

    if @unread_posts.length() == 0
      session[:unread_posts] = nil
    end

    @posts = Post.all
    @all_categories = Post.all_categories
    @categories_to_show = params[:categories] ? params[:categories].keys : @all_categories
    @posts = Post.with_categories(@categories_to_show)
    @keyword_to_show = params[:keyword] ? params[:keyword] : ""
    @min_price = params[:min_price] ? params[:min_price] : ""
    @max_price = params[:max_price] ? params[:max_price] : ""
    puts "the keyboard are: "
    puts params[:categories]
    # Keyword
    res = []
    @posts.each do |post|
      if post.with_keyword(@keyword_to_show)
          res.append(post)
      end
    end
    @posts = res

    # Price Range
    if @min_price.length != 0 or @max_price.length != 0
      # Digit type match
      if (not @min_price.match?(/[[:digit:]]/) and not @max_price.match?(/[[:digit:]]/))
        flash[:notice] = "Invalid price range"
        redirect_to posts_path and return
      end
    end

    # consider unfilled
    if @min_price.length == 0
      @min_price = Float::MIN
    end
    if @max_price.length == 0
      @max_price = Float::MAX
    end

    # min_price > max_price comparison
    @min_price = @min_price.to_f
    @max_price = @max_price.to_f
    if (@min_price > @max_price)
      flash[:notice] = "Invalid price range"
      redirect_to posts_path and return
    end

    res = []
    @posts.each do |post|
      # Price filter
      if post.with_price_range(@min_price, @max_price)
        res.append(post)
      end
    end
    @posts = res
  end

  def new
    # default: render 'new' template
    if session[:user_id] != nil
      #redirect_to signin_path and return
      user_id = session[:user_id]
      user = User.find_by(id:user_id)
      @user_name = user.fname+ " " +user.lname
      @user_email = user.email
    end
  end

  def create
    # Prevent hacker
    if session[:user_id] != nil
      puts post_params
      tmp = post_params
      tmp[:closed] = false

      if post_params[:price].length > 0
        if post_params[:price].to_f < post_params[:start_bid].to_f
          flash[:notice] = "Price should be greater than the bidding price."
          redirect_to new_post_path and return
        end
      end

      if post_params[:price].length == 0 and post_params[:start_bid].length == 0
        tmp[:current_bid] = post_params[:start_bid]
        tmp[:price] = "1"
        tmp[:buy_now] = true
        tmp[:bid] = false
      else
        if post_params[:price].length > 0
          tmp[:buy_now] = true
        else
          tmp[:buy_now] = false
        end
        if post_params[:start_bid].length > 0
          tmp[:bid] = true
        else
          tmp[:bid] = false
        end
        tmp[:current_bid] = post_params[:start_bid]
      end

      puts tmp
      puts "categor ys "
      puts post_params[:category]
      Post.create!(tmp)
      flash[:notice] = "#{tmp[:item]} was successfully created."
      redirect_to poster_path and return
    end
  end

  def edit
      # Prevent hacker
    @post = Post.find params[:id]
  end

  def update
    #  Prevent hacker
     if session[:user_id] != nil
       if post_params[:price].length > 0
         if post_params[:price].to_f < post_params[:start_bid].to_f
           flash[:notice] = "Price should be greater than the bidding price."
           redirect_to "/edit_post?id="+post_params[:id].to_s  and return
         end
       end
       bidder = Bid.find_by(product_id: post_params[:id])
       if bidder != nil #and bidder.bid != post_params[:start_bid]
         puts "the id is"
         puts post_params[:id]
         flash[:notice] = "You are not allowed to change the start bid when someone bid already. You can delete this post and re-post it again."
         redirect_to "/edit_post?id="+post_params[:id].to_s  and return
       end
       tmp = post_params
       if post_params[:price].length == 0 and post_params[:start_bid].length == 0
         tmp[:current_bid] = post_params[:start_bid]
         tmp[:price] = "1"
         tmp[:buy_now] = true
         tmp[:bid] = false
       else
         if post_params[:price].length > 0
           tmp[:buy_now] = true
         else
           tmp[:buy_now] = false
         end
         if post_params[:start_bid].length > 0
           tmp[:bid] = true
         else
           tmp[:bid] = false
         end
         tmp[:current_bid] = post_params[:start_bid]
       end
       puts tmp

       @post = Post.find post_params[:id]
       @post.update_attributes!(tmp)
       flash[:notice] = "#{@post.item} was successfully updated."
       redirect_to post_path(@post) and return
     end
   end

  def destroy
    # Prevent hacker
    if session[:user_id] != nil
      @post = Post.find(params[:id])
      @post.destroy
      flash[:notice] = "Post '#{@post.item}' deleted."
      redirect_to poster_path and return
    end
  end

  def my_posts
    if session[:user_id] == nil
      redirect_to "/signin" and return
    end
    user_id = session[:user_id]
    user = User.find_by(id:user_id)
    user_name = user.fname+user.lname
    user_email = user.email
    # opts = {}
    # opts["item"] = params[:item] if params[:item].present?
    # opts["price"] = params[:item] if params[:price].present?
    @posts = Post.where(email:user_email,closed:false)
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def post_params
    params.require(:post).permit(:image, :item, :description, :price, :user, :email, :start_bid, :id, :category)
  end
end
