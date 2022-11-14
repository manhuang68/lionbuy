class UsersController < ApplicationController

  def index
    #@user = User.new
  end

  def create
    #puts "this is"
    #puts (user_params[:email].include? "@columbia.edu")
    if (!user_params[:email].include? "@columbia.edu") and (!user_params[:email].include? "@barnard.edu")
      flash[:notice] = 'Please use Columbia or Barnard Email to register!'
      redirect_to "/signup" and return
    end
    if user_params[:fname].empty? or user_params[:lname].empty?
      flash[:notice] = 'Fields cannot be empty!'
      redirect_to "/signup" and return
    end

    if user_params[:password].empty?
      flash[:notice] = 'Password cannot be empty!'
      redirect_to "/signup" and return
    end
    user = User.find_by(email: user_params[:email])
    #puts user
    if user != nil
      flash[:notice] = 'Email already exist!'
      redirect_to "/signup" and return
    end
    if user_params[:password] != user_params[:password_confirmation]
      #puts user_params[:password]
      #puts user_params[:password_confirmation]
      flash[:notice] = 'Password does not match!'
      redirect_to "/signup" and return
    end


    #puts "tt"
    #puts user_params
    r = user_params.except(:password_confirmation)
    #puts r
    user = User.create(r)
    if user.save
      session[:user_id] = user.id
      session[:fname] = user.fname
      session[:lname] = user.lname
    #  session[:image] = user.image.url(:medium)
      flash[:notice] = 'Account registered successfully!'
      redirect_to root_url and return
    #else
    #  flash[:notice] = user.errors.full_messages
    #  redirect_to "/signup" and return
    end
  end

  def update

  end

  private
  def user_params
    params.require(:user).permit(:image, :email, :password,:password_confirmation, :fname, :lname)
  end
end
