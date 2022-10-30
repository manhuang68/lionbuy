class PostsController < ApplicationController

  def show
    id = params[:id] # retrieve post ID from URI route
    @post = Post.find(id) # look up post by unique ID
    # will render app/views/posts/show.<extension> by default
  end

  def index
    @posts = Post.all
    if not params[:categories] and not params[:sort]
      if session[:sort] or session[:categories]
        params[:categories] = session[:categories]
        params[:sort] = session[:sort]
        redirect_to posts_path({:categories => params[:categories], :sort => params[:sort]})
        return
      end
    end
    session.delete(:categories)
    session.delete(:sort)

    @all_categories = Post.all_categories
    @categories_to_show = params[:categories] ? params[:categories].keys : @all_categories
    @title_header_hilite_to_show = params[:sort] == 'title' ? 'hilite bg-warning' : ''
    @release_date_header_hilite_to_show = params[:sort] == 'release_date' ? 'hilite bg-warning' : ''
    
    @posts = Post.with_categories(@categories_to_show)
    if params[:sort]
      @posts = @posts.order(params[:sort])
      session[:sort] = params[:sort]
    end

    if params[:categories]
      session[:categories] = params[:categories]
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
    @post = Post.create!(post_params)
    flash[:notice] = "#{@post.item} was successfully created."
    redirect_to posts_path
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    @post.update_attributes!(post_params)
    flash[:notice] = "#{@post.item} was successfully updated."
    redirect_to post_path(@post)
  end

  def destroy
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
