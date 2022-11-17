class PostsController < ApplicationController

  def show
    if session[:user_id] == nil
      redirect_to signin_path and return
    end
    @item = Post.find_by(id: params[:id])
  end

  def index
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to signin_path and return
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
      if (not @min_price.match?(/[[:digit:]]/) and not @max_price.match?(/[[:digit:]]/))
        flash[:notice] = "Invalid price range"
        redirect_to posts_path and return
      end
    end

    res = []
    @posts.each do |post|
      if post.with_price_range(@min_price, @max_price)
          res.append(post)
      end
    end
    @posts = res

    # byebug
    if params[:categories]
      session[:categories] = params[:categories]
    end
    if params[:keyword]
      session[:keyword] = params[:keyword]
    end
    if params[:min_price]
      session[:min_price] = params[:min_price]
    end
    if params[:max_price]
      session[:max_price] = params[:max_price]
    end
  end

  def new
    # default: render 'new' template
    user_id = session[:user_id]
    user = User.find_by(id:user_id)
    @user_name = user.fname+user.lname
    @user_email = user.email
  end

  def create
    # Prevent hacker
    puts post_params
    tmp = post_params
    tmp[:closed] = false
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
    puts tmp
    puts "categor ys "
    puts post_params[:category]
    Post.create!(tmp)
    flash[:notice] = "#{tmp[:item]} was successfully created."
    redirect_to poster_path and return
  end

  def edit
      # Prevent hacker
      if session[:user_id] == nil
        redirect_to "/signin" and return
      end
    @post = Post.find params[:id]
  end

  def update
    #  Prevent hacker
     if session[:user_id] == nil
       redirect_to "/signin" and return
     end
     bidder = Bid.find_by(product_id: post_params[:id])
     if bidder != nil #and bidder.bid != post_params[:start_bid]
       puts "the id is"
       puts post_params[:id]
       flash[:notice] = "You are not allowed to change the start bid when someone bid already. You can delete this post and re-post it again."
       redirect_to "/edit_post?id="+post_params[:id].to_s  and return
     end
     tmp = post_params
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
     puts tmp

     @post = Post.find post_params[:id]
     @post.update_attributes!(tmp)
     flash[:notice] = "#{@post.item} was successfully updated."
     redirect_to post_path(@post) and return
   end

  def destroy
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin" and return
    end
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post '#{@post.item}' deleted."
    redirect_to poster_path and return
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
    @posts = Post.where(user:user_name,email:user_email)
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def post_params
    params.require(:post).permit(:item, :description, :price, :user, :email, :start_bid, :id, :category)
  end
end
