class PostsController < ApplicationController

  def show
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end
    # id = params[:id] # retrieve post ID from URI route
    # @post = Post.find(id) # look up post by unique ID
  end

  def index
    session.delete(:min_price)
    session.delete(:max_price)
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end

    @posts = Post.all
    if not params[:categories] and not params[:keyword] and not params[:min_price] and not params[:max_price]
      if session[:categories] or session[:keyword] or (session[:min_price] and session[:max_price])
        params[:categories] = session[:categories]
        params[:keyword] = session[:keyword]
        params[:min_price] = session[:min_price]
        params[:max_price] = session[:max_price]
        redirect_to posts_path({:categories => params[:categories], :keyword => params[:keyword], :min_price => params[:min_price], :max_price => params[:max_price]})
        return
      end
    end
    session.delete(:categories)
    session.delete(:keyword)
    session.delete(:min_price)
    session.delete(:max_price)

    @all_categories = Post.all_categories
    @categories_to_show = params[:categories] ? params[:categories].keys : @all_categories
    @posts = Post.with_categories(@categories_to_show)
    @keyword_to_show = params[:keyword] ? params[:keyword] : ""
    @min_price = params[:min_price] ? params[:min_price] : ""
    @max_price = params[:max_price] ? params[:max_price] : ""

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
        redirect_to posts_path
      end
    end

    res = []
    @posts.each do |post|
      if post.with_price_range(@min_price, @max_price)
          res.append(post)
      end
    end
    @posts = res
  end

  def new
    # default: render 'new' template
  end

  def create
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end
    @post = Post.create!(post_params)
    flash[:notice] = "Post #{@post.item} was successfully created."
    redirect_to posts_path
  end

  def edit
      # Prevent hacker
      if session[:user_id] == nil
        redirect_to "/signin"
      end
    @post = Post.find params[:id]
  end

  def update
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end
    @post = Post.find params[:id]
    @post.update_attributes!(post_params)
    flash[:notice] = "Post #{@post.item} was successfully updated."
    redirect_to post_path(@post)
  end

  def destroy
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post '#{@post.item}' deleted."
    redirect_to posts_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def post_params
    params.require(:post).permit(:item, :description, :price, :user, :email)
  end
end
