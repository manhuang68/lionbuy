class PostsController < ApplicationController

  def show
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end
    id = params[:id] # retrieve post ID from URI route
    @post = Post.find(id) # look up post by unique ID
  end

  def index
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end

    @posts = Post.all
    if not params[:categories] and not params[:keyword]
      if session[:categories] or session[:keyword]
        params[:categories] = session[:categories]
        params[:keyword] = session[:keyword]
        redirect_to posts_path({:categories => params[:categories], :keyword => params[:keyword]})
        return
      end
    end
    session.delete(:categories)
    session.delete(:keyword)

    @all_categories = Post.all_categories
    @categories_to_show = params[:categories] ? params[:categories].keys : @all_categories
    @posts = Post.with_categories(@categories_to_show)
    @keyword_to_show = params[:keyword] ? params[:keyword] : ""

    res = []
    @posts.each do |post| 
      if post.with_keyword(@keyword_to_show)
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
  end

  def new
    # default: render 'new' template
  end

  def search
    @similar_posts = Post.similar_posts(params[:item])
    if @similar_posts.nil?
      flash[:notice] = "'#{params[:item]}' has no director info"
      redirect_to root_url
    end
    @post = Post.find_by(item: params[:item])
  end

  def create
    # Prevent hacker
    if session[:user_id] == nil
      redirect_to "/signin"
    end
    @post = Post.create!(post_params)
    flash[:notice] = "#{@post.item} was successfully created."
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
    flash[:notice] = "#{@post.item} was successfully updated."
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
